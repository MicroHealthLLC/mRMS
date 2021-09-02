module ChannelPermissionHelper

  def permission_sort(permissions,channel)
    permissions_data = permissions
    if (permissions.count > 1)
      owner = []
      data = permissions.where.not(user_id: channel.user_id)
      owner << permissions.find_by(user_id: channel.user_id)
      permissions_data = owner.concat(data)
    end
    permissions_data
  end
end
