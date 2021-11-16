module ChannelsHelper

	def pivot_table_reports?(channel)
    if channel.shared_report?
      report_ids = User.current.reports.current_user_shared_reports
      pivot_table = SavePivotTable.where(report_id: report_ids)
    else
  		report_ids = channel.reports.pluck(:id)
  		pivot_table = SavePivotTable.where(report_id: report_ids)
    end
		return !pivot_table.present?
	end

	def display_multi_data_set_dashboard?
    (@channel.is_group? && @channel.my_permission.can_manage_multi_dataset_dashboard?) || @channel.shared_report? || @channel.is_public? || (@channel.is_personal? && @channel.is_creator?)
  end
end
