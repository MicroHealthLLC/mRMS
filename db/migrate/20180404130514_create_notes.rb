class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string   "type"
      t.integer  "owner_id"
      t.text     "note",              limit: 65535
      t.integer  "user_id"
      t.datetime "created_at",                                      null: false
      t.datetime "updated_at",                                      null: false
      t.boolean  "is_private",                      default: false
      t.integer  "private_author_id"
      t.integer  "updated_by_id"
      t.integer  "created_by_id"
      t.index ["owner_id"], name: "index_notes_on_owner_id", using: :btree
      t.index ["type"], name: "index_notes_on_type", using: :btree
      t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
    end
  end
end
