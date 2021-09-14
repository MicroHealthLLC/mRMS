class OneDriveRefreshService
  attr_reader :access_token, :drive_items, :user

  def initialize (user, report_document)
    @user = user
    @report_document = report_document
    @access_token = user.onedrive_access_token
    @drive_items = []
  end

  def call
    data = get_one_drive_data

    if data["error"].present?
      data = get_new_access_token
    end
  rescue StandardError => e
    puts e.message
  end

  private

  def get_one_drive_data
    id = @report_document.onedrive_item_id
    url = "https://graph.microsoft.com/v1.0/drives/5B60EC214464CB9E/items/#{id}"
    items = JSON.parse(HTTParty.get(url,headers: set_headers).body)
    file_url = items["@microsoft.graph.downloadUrl"]
    file_name = items["name"]
    File.open("public/uploads/tmp/#{file_name}", 'wb') do |file|
      file << open(file_url).read
      @report_document.file = file
    end
    @report_document.save
  end

  def get_new_access_token
    options = { :body =>
      { "client_id" => "#{Setting['AZURE_KEY']}",
        "redirect_uri" => "#{Setting['CALLBACK_URL']}/auth/microsoft_graph_auth/callback",
        "client_secret" => "#{Setting['AZURE_SECRET']}",
        "refresh_token" => "#{@user.onedrive_refresh_token}",
        "grant_type" => "refresh_token"
      },
      :headers => { 'Content-Type' => 'application/x-www-form-urlencoded'}
    }

    results = HTTParty.post("https://login.live.com/oauth20_token.srf", options)
    @access_token = results.parsed_response["access_token"]
    @user.update!(onedrive_access_token: results.parsed_response["access_token"],
                  onedrive_refresh_token: results.parsed_response["refresh_token"])
    get_one_drive_docs
  end

  def set_headers
      {"Content-Type"=> 'application/json',"Authorization"=>"bearer #{@access_token}"}
    end
end
