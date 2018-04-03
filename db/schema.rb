# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180402171734) do

  create_table "addresses", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "attachments", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "core_demographics", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "email_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "email_type"
    t.boolean  "status",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["email_type"], name: "index_email_notifications_on_email_type", using: :btree
    t.index ["name"], name: "index_email_notifications_on_name", using: :btree
  end

  create_table "email_templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "header",     limit: 65535
    t.text     "body",       limit: 65535
    t.text     "footer",     limit: 65535
    t.string   "model"
    t.text     "stylesheet", limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "emails", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email_address"
    t.integer  "email_type_id"
    t.integer  "extend_demography_id"
    t.text     "note",                 limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "enabled_modules", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.boolean  "status",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "enumerations", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "name",          limit: 100, default: "",    null: false
    t.integer "position"
    t.boolean "is_default",                default: false, null: false
    t.string  "type"
    t.boolean "active",                    default: true,  null: false
    t.string  "position_name", limit: 100
    t.boolean "is_flagged",                default: false
    t.boolean "is_closed",                 default: false
  end

  create_table "extend_demographies", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "type"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_extend_demographies_on_user_id", using: :btree
  end

  create_table "faxes", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "fax_number"
    t.integer  "fax_type_id"
    t.integer  "extend_demography_id"
    t.text     "note",                 limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "identifications", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "news", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "note_templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.text     "note",            limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.integer  "organization_id"
    t.index ["organization_id"], name: "index_note_templates_on_organization_id", using: :btree
  end

  create_table "old_passwords", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "encrypted_password",       null: false
    t.string   "password_archivable_type", null: false
    t.string   "password_salt"
    t.integer  "password_archivable_id",   null: false
    t.datetime "created_at"
    t.index ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable", using: :btree
  end

  create_table "phones", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "phone_number"
    t.integer  "phone_type_id"
    t.integer  "extend_demography_id"
    t.text     "note",                 limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "roles", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "settings", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "home_page_content", limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "setting_type"
    t.text     "value",             limit: 65535
  end

  create_table "social_media", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "social_media_type_id"
    t.text     "note",                 limit: 65535
    t.string   "social_media_handle"
    t.integer  "extend_demography_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "users", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",                                  default: "",    null: false
    t.string   "login",                                  default: "",    null: false
    t.text     "note",                     limit: 65535
    t.boolean  "state",                                  default: false
    t.boolean  "admin",                                  default: false
    t.string   "encrypted_password",                     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "avatar"
    t.datetime "deleted_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "database_authenticatable"
    t.string   "ldap_authenticatable",                                   null: false
    t.datetime "last_seen_at"
    t.integer  "role_id"
    t.boolean  "anonyme_user",                           default: false
    t.datetime "password_changed_at"
    t.datetime "last_activity_at"
    t.datetime "expired_at"
    t.string   "unique_session_id",        limit: 20
    t.integer  "last_project_used_id"
    t.string   "authy_id"
    t.datetime "last_sign_in_with_authy"
    t.boolean  "authy_enabled",                          default: false
    t.string   "time_zone"
    t.string   "uuid"
    t.index ["authy_id"], name: "index_users_on_authy_id", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["expired_at"], name: "index_users_on_expired_at", using: :btree
    t.index ["last_activity_at"], name: "index_users_on_last_activity_at", using: :btree
    t.index ["password_changed_at"], name: "index_users_on_password_changed_at", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

end
