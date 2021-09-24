class OneDriveRefreshService
  attr_reader :access_token, :drive_items, :user

  def initialize (user, report_document)
    @user = user
    @report_document = report_document
    @access_token = user.onedrive_access_token
    @drive_items = []
  end

  def call
    get_one_drive_data
  end

  private

  def get_one_drive_data
    url = nil
    type = 'notice'
    message = "Data Successfully Updated!"
    item_id = @report_document.onedrive_item_id
    puts "item_id: #{item_id}"
    item_url = "https://graph.microsoft.com/v1.0/me/drive/items/#{item_id}"
    items = JSON.parse(HTTParty.get(item_url, headers: set_headers).body)

    if items["error"].present?
      if items["error"]["message"] == 'Item does not exist'
        message = items["error"]["message"] + " on Drive, Please re-upload file!"
        type = 'alert'
      elsif @user.onedrive_refresh_token.present?
        get_new_access_token
      else
        url = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=#{Setting['AZURE_KEY']}&scope=#{ENV['AZURE_SCOPES']}&response_type=code&redirect_uri=#{Setting['CALLBACK_URL']}/auth/microsoft_graph_auth/callback"
        message = "Re-Authenticated!"
      end
    elsif items["@microsoft.graph.downloadUrl"].present?
      file_url = items["@microsoft.graph.downloadUrl"] || nil
      file_name = items["name"] || nil
      puts "file_url: #{file_url}, file_name: #{file_name}"
      if file_url.present? && file_name.present?
        File.open("public/uploads/tmp/#{file_name}", 'wb') do |file|
          file << open(file_url).read
          @report_document.file = file
        end
        @report_document.save
        `rm public/uploads/tmp/#{file_name}`
      end
    else
      message = "System Error contact to Admin!"
      type = 'alert'
    end
    return {url: url, message: message, type: type}
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
    get_one_drive_data
  end

  def set_headers
    {"Content-Type"=> 'application/json',"Authorization"=>"bearer #{@access_token}"}
  end
end
