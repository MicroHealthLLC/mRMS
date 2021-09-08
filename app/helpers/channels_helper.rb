module ChannelsHelper

	def pivot_table_reports?(channel)
		report_ids = channel.reports.pluck(:id)
		pivot_table = SavePivotTable.where(report_id: report_ids)
		return !pivot_table.present?
	end

	def display_multi_data_set_dashboard?
    (@channel.is_group? && @channel.my_permission.can_manage_multi_dataset_dashboard?) or @channel.is_public? or (@channel.is_personal? && @channel.is_creator?)
  end
end
