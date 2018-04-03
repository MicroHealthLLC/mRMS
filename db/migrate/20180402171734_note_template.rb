class NoteTemplate < ActiveRecord::Migration[5.0]
  def change
    create_table "note_templates" do |t|
      t.string   "title"
      t.text     "note",            limit: 65535
      t.datetime "created_at",                    null: false
      t.datetime "updated_at",                    null: false
      t.integer  "updated_by_id"
      t.integer  "created_by_id"
      t.integer  "organization_id"
      t.index ["organization_id"], name: "index_note_templates_on_organization_id", using: :btree
    end
  end
end
