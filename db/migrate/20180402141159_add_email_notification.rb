class AddEmailNotification < ActiveRecord::Migration[5.0]
  def change
    create_table "email_notifications" do |t|
      t.string   "name"
      t.string   "email_type"
      t.boolean  "status",     default: true
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
      t.index ["email_type"], name: "index_email_notifications_on_email_type", using: :btree
      t.index ["name"], name: "index_email_notifications_on_name", using: :btree
    end

    create_table "email_templates" do |t|
      t.text     "header",     limit: 65535
      t.text     "body",       limit: 65535
      t.text     "footer",     limit: 65535
      t.string   "model"
      t.text     "stylesheet", limit: 65535
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
    end
  end
end
