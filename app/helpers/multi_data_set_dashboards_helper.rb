module MultiDataSetDashboardsHelper

  def pluck_pivot_table_ids(multi_dashboard, params)
    pluckIds = []
    if params[:action] == "edit"
      multi_dashboard.shared_multi_report_dashboards.order(:order_index).each do|dash|
        pluckIds.push(dash.pivot_table_id)
      end
    elsif params["pivot_table_ids"].present?
      pluckIds = JSON.parse(params["pivot_table_ids"])
    end
    return pluckIds
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
