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

ActiveRecord::Schema.define(version: 20150809071814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.integer  "room_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attachments", ["room_id"], name: "index_attachments_on_room_id", using: :btree

  create_table "pins", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "sms_confirmable_id"
    t.string   "sms_confirmable_type"
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.decimal  "price",       precision: 8, scale: 2
    t.json     "images"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "room_type"
    t.integer  "direction"
    t.integer  "gender"
    t.integer  "amenity",                             default: [],              array: true
    t.integer  "furniture",                           default: [],              array: true
    t.integer  "extra_fee",                           default: [],              array: true
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.date     "start_school_year"
    t.boolean  "verified",          default: false
    t.integer  "school_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "sign_with_zuker"
  end

  add_index "users", ["phone_number"], name: "index_users_on_phone_number", unique: true, using: :btree
  add_index "users", ["school_id"], name: "index_users_on_school_id", using: :btree

  add_foreign_key "attachments", "rooms"
  add_foreign_key "users", "schools"
end
