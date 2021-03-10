class OneDriveService
  attr_reader :access_token, :drive_items

  def initialize access_token
    @access_token = access_token
    @drive_items = []
  end

  def call
    one_drive = OneDrive::V1.new(ENV['AZURE_APP_ID'], "#{ENV['CALLBACK_URL']}/auth/microsoft_graph_auth/callback", ENV['AZURE_SCOPES'])
    one_drive.set_token @access_token

    children = one_drive.get_children_of_special_folder('Documents')['value']
    get_items_from_children(children)

  rescue StandardError => e
    puts e.message
  end

  private

  def get_items_from_children children
    children.each do |child|
      if child['folder'].present? && child['folder']['childCount'] > 0
        nested_children = get_nested_children(child)
        get_items_from_children(nested_children)
      else
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
end
