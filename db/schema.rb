# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150707022532) do

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "order_number", limit: 255
    t.integer  "quantity",     limit: 4
    t.decimal  "total_price",              precision: 8, scale: 2
    t.string   "status",       limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "order_id",         limit: 4
    t.string   "payment_method",   limit: 255
    t.string   "payment_date",     limit: 255
    t.string   "payment_time",     limit: 255
    t.string   "reference_number", limit: 255
    t.decimal  "total_payment",                precision: 8, scale: 2
    t.string   "attachment",       limit: 255
    t.string   "receipt_number",   limit: 255
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "status",           limit: 255
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id", using: :btree
  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "fname",        limit: 255
    t.string   "lname",        limit: 255
    t.text     "address1",     limit: 65535
    t.text     "address2",     limit: 65535
    t.string   "postcode",     limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "country",      limit: 255
    t.string   "phone_number", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "username",               limit: 255, default: "", null: false
    t.boolean  "admin"
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
  add_foreign_key "payments", "users"
  add_foreign_key "profiles", "users"
end
