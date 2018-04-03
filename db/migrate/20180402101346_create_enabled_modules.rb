class CreateEnabledModules < ActiveRecord::Migration[5.1]
  def change
    create_table :enabled_modules do |t|
      t.string   "name"
      t.boolean  "status",     default: true
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
    end
  end
end
