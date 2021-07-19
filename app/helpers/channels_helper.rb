module ChannelsHelper

	def pivot_table_reports?(channel)
		report_ids = channel.reports.pluck(:id)
		pivot_table = SavePivotTable.where(report_id: report_ids)
		return !pivot_table.present?
	end
end
