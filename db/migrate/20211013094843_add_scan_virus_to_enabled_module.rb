class AddScanVirusToEnabledModule < ActiveRecord::Migration[5.2]
  def change
    EnabledModule.find_or_create_by(name: "scan_virus", status: true)
  end
end
