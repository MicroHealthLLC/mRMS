class AddAttachment < ActiveRecord::Migration[5.0]
  def change
    create_table "attachments" do |t|
      t.string   "type"
      t.string   "file"
      t.string   "description"
      t.integer  "owner_id"
      t.datetime "created_at",    null: false
      t.datetime "updated_at",    null: false
      t.integer  "user_id"
      t.integer  "updated_by_id"
      t.integer  "created_by_id"
      t.index ["user_id"], name: "index_attachments_on_user_id", using: :btree
    end
  end
end
