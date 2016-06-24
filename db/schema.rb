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

ActiveRecord::Schema.define(version: 20160624184825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "name",       limit: 255
    t.integer  "kind"
  end

  create_table "clients", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "email"
    t.text     "observations"
    t.integer  "status"
  end

  create_table "incomings", force: :cascade do |t|
    t.date     "day"
    t.decimal  "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "items", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.string   "name"
    t.decimal  "cost_price"
    t.decimal  "unitary_price"
    t.integer  "quantity"
    t.integer  "status"
    t.text     "description"
  end

  create_table "outgoings", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.date     "day"
    t.decimal  "value"
    t.string   "description", limit: 255
    t.integer  "category_id"
  end

  create_table "sale_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sale_id"
    t.integer  "item_id"
    t.decimal  "price"
    t.integer  "quantity"
  end

  create_table "sales", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "client_id"
    t.date     "date"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.date     "birth_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255, null: false
    t.string   "password_salt",          limit: 255
    t.string   "password_hash",          limit: 255
    t.integer  "role"
    t.boolean  "confirmed"
    t.string   "auth_token",             limit: 255
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["id"], name: "index_users_on_id", using: :btree

end
