class AddCoreDemographic < ActiveRecord::Migration[5.0]
  def change
    create_table "core_demographics" do |t|
      t.integer  "user_id"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "middle_name"
      t.integer  "gender_id"
      t.date     "birth_date"
      t.integer  "religion_id"
      t.string   "title"
      t.text     "note",                limit: 65535
      t.integer  "ethnicity_id"
      t.datetime "created_at",                        null: false
      t.datetime "updated_at",                        null: false
      t.integer  "citizenship_type_id"
      t.integer  "marital_status_id"
      t.integer  "updated_by_id"
      t.integer  "created_by_id"
      t.float    "height",              limit: 24
      t.float    "weight",              limit: 24
      t.string   "ethnicity"
      t.string   "religion"
      t.string   "gender"
      t.integer  "civility_title_id"
    end
  end
end
