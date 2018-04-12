class AddExtendDemography < ActiveRecord::Migration[5.0]
  def change
    create_table "extend_demographies" do |t|
      t.integer  "user_id"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
      t.string   "type"
      t.integer  "updated_by_id"
      t.integer  "created_by_id"
      t.index ["user_id"], name: "index_extend_demographies_on_user_id", using: :btree
    end

    create_table "addresses"  do |t|
      t.integer  "address_type_id"
      t.string   "address"
      t.string   "city"
      t.string   "zip_code"
      t.string   "state"
      t.string   "country_code"
      t.datetime "created_at",                      null: false
      t.datetime "updated_at",                      null: false
      t.integer  "extend_demography_id"
      t.integer  "country_id"
      t.integer  "state_id"
      t.string   "second_address"
      t.float    "location_lat",         limit: 24
      t.float    "location_long",        limit: 24
    end

    create_table "faxes"  do |t|
      t.string   "fax_number"
      t.integer  "fax_type_id"
      t.integer  "extend_demography_id"
      t.text     "note",                 limit: 65535
      t.datetime "created_at",                         null: false
      t.datetime "updated_at",                         null: false
    end
    create_table "phones"  do |t|
      t.string   "phone_number"
      t.integer  "phone_type_id"
      t.integer  "extend_demography_id"
      t.text     "note",                 limit: 65535
      t.datetime "created_at",                         null: false
      t.datetime "updated_at",                         null: false
    end
    create_table "social_media"  do |t|
      t.integer  "social_media_type_id"
      t.text     "note",                 limit: 65535
      t.string   "social_media_handle"
      t.integer  "extend_demography_id"
      t.datetime "created_at",                         null: false
      t.datetime "updated_at",                         null: false
    end
    create_table "emails"  do |t|
      t.string   "email_address"
      t.integer  "email_type_id"
      t.integer  "extend_demography_id"
      t.text     "note",                 limit: 65535
      t.datetime "created_at",                         null: false
      t.datetime "updated_at",                         null: false
    end

    create_table "identifications"  do |t|
      t.string   "identification_number"
      t.boolean  "status"
      t.date     "date_expired"
      t.string   "date_issued"
      t.text     "note",                     limit: 65535
      t.integer  "identification_type_id"
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
      t.integer  "extend_demography_id"
      t.integer  "issued_by_type_id"
      t.integer  "identification_status_id"
    end


  end
end
