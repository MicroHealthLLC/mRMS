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
  def can_manage_multi_dataset_dashboard?(channel)
    can_manage = false
    if channel.is_group?
      permission = channel.channel_permissions.find_by(user_id: current_user.id)
      if permission
        can_manage = permission.can_manage_multi_dataset_dashboard
      end
    elsif channel.is_public?
      can_manage = true
    elsif channel.is_personal?
      can_manage = (current_user.id == channel.user.id)
    end
    can_manage
  end

  def can_manage_dashboard?(channel)
    can_manage = false
    if channel.is_group?
      permission = channel.channel_permissions.find_by(user_id: current_user.id)
      if permission
        can_manage = permission.can_manage_dashboard
      end
    elsif channel.is_public?
      can_manage = true
    elsif channel.is_personal?
      can_manage = (current_user.id == channel.user.id)
    end
    can_manage
  end
end
