class AddChannelIdToSharedReport < ActiveRecord::Migration[5.0]
  def change
    add_column :shared_reports, :channel_id, :integer
    add_index :shared_reports, :channel_id

    SharedReport.all.each do |sr|
      sr.channel_id = sr.report.try(:channel_id)
      sr.save
    end
  end
end
