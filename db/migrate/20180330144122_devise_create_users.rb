# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
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
end
