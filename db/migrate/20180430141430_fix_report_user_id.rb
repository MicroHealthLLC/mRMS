class FixReportUserId < ActiveRecord::Migration[5.0]
  def change
    Report.all.each do |r|
      r.user_id = r.channel.user_id if r.channel
      r.save
      r.shared_reports.where(user_id: nil).update_all({user_id: r.user_id})
    end
  end
end
