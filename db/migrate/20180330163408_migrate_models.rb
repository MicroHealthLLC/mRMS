class MigrateModels < ActiveRecord::Migration[5.1]
  def change
    create_table "enumerations", force: :cascade do |t|
      t.string  "name",          limit: 100, default: "",    null: false
      t.integer "position"
      t.boolean "is_default",                default: false, null: false
      t.string  "type"
      t.boolean "active",                    default: true,  null: false
      t.string  "position_name", limit: 100
      t.boolean "is_flagged",                default: false
      t.boolean "is_closed",                 default: false
    end

    create_table "settings", force: :cascade  do |t|
      t.text     "home_page_content", limit: 65535
      t.datetime "created_at",                      null: false
      t.datetime "updated_at",                      null: false
      t.string   "setting_type"
      t.text     "value",             limit: 65535
    end

    create_table "news", force: :cascade do |t|
      t.string   "title"
      t.string   "summary"
      t.text     "description",   limit: 65535
      t.integer  "user_id"
      t.integer  "notes_count"
      t.datetime "created_at",                  null: false
      t.datetime "updated_at",                  null: false
      t.integer  "updated_by_id"
      t.integer  "created_by_id"
    end

    create_table "roles", force: :cascade do |t|
      t.boolean  "state"
      t.text     "note",          limit: 65535
      t.datetime "created_at",                  null: false
      t.datetime "updated_at",                  null: false
      t.integer  "role_type_id"
      t.text     "permissions",   limit: 65535
      t.string   "name"
      t.integer  "updated_by_id"
      t.integer  "created_by_id"
    end



  end
end
