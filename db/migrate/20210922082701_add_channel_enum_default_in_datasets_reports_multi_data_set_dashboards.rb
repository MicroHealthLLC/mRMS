class AddChannelEnumDefaultInDatasetsReportsMultiDataSetDashboards < ActiveRecord::Migration[5.2]
  def change
    channel_enum = ChannelEnum.find_or_create_by(name:"Uncategorized")

    MultiDataSetDashboard.all.each do|dashboard|
      if dashboard.channel_enum.nil?
        dashboard.update(channel_enum_id: channel_enum.id)
      end
    end

    SavePivotTable.all.each do |report|
      if report.channel_enum.nil?
        report.update(channel_enum_id:channel_enum.id)
      end
    end

    Report.all.each do |report|
      if report.channel_enum.nil?
        report.update(channel_enum_id:channel_enum.id)
      end
    end

  end
end
