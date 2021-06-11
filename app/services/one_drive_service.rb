class OneDriveService
  attr_reader :access_token, :drive_items, :user

  def initialize user
    @user = user
    @access_token = user.onedrive_access_token
    @drive_items = []
  end

  def call
    data = get_one_drive_docs

    if data["error"].present?
      data = get_new_access_token
    end

    children = data["value"]
    get_items_from_children(children)

  rescue StandardError => e
    puts e.message
  end

  private

  def get_one_drive_docs
    one_drive = OneDrive::V1.new(Setting['AZURE_KEY'], "#{Setting['CALLBACK_URL']}/auth/microsoft_graph_auth/callback", ENV['AZURE_SCOPES'])
    one_drive.set_token @access_token
    one_drive.get_children_of_special_folder('Documents')
  end

  def get_items_from_children children
    children.each do |child|
      if child['folder'].present? && child['folder']['childCount'] > 0
        nested_children = get_nested_children(child)
        get_items_from_children(nested_children)
      else
        next unless ['csv', 'xls', 'xlsx'].include? child["name"].split('.')[1]
        @drive_items << child
      end
    end
    @drive_items
  end

  def get_nested_children child
    drive_id = child['parentReference']['driveId']
    item_id = child['id']

    url = "https://graph.microsoft.com/v1.0/drives/#{drive_id}/items/#{item_id}/children"
    resp = HTTParty.get(url, headers: {"Content-Type"=> 'application/json',"Authorization"=>"bearer #{@access_token}"})
    JSON.parse(resp.body)['value']
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
end
