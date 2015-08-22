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

ActiveRecord::Schema.define(version: 20150820072331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.integer  "house_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attachments", ["house_id"], name: "index_attachments_on_house_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "author_id",        null: false
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree

  create_table "houses", force: :cascade do |t|
    t.string   "title"
    t.string   "city"
    t.string   "district"
    t.string   "address"
    t.string   "zipcode"
    t.boolean  "hide_address"
    t.text     "description"
    t.decimal  "price",                precision: 8, scale: 2
    t.decimal  "security_fee",         precision: 8, scale: 2, default: 0.0
    t.integer  "school_id"
    t.integer  "house_type"
    t.integer  "gender"
    t.integer  "personal_parking_lot"
    t.integer  "foreigner"
    t.integer  "special_floor"
    t.integer  "min_lease"
    t.boolean  "english_help"
    t.boolean  "photo_help"
    t.integer  "direction",                                    default: [],               array: true
    t.integer  "amenity",                                      default: [],               array: true
    t.integer  "furniture",                                    default: [],               array: true
    t.integer  "extra_fee",                                    default: [],               array: true
    t.integer  "public_facility",                              default: [],               array: true
    t.integer  "rule",                                         default: [],               array: true
    t.integer  "safety",                                       default: [],               array: true
    t.integer  "building_floor",                               default: 0
    t.integer  "at_floor",                                     default: 0
    t.integer  "area",                                         default: 0
    t.integer  "bedroom",                                      default: 0
    t.integer  "shared_space",                                 default: 0
    t.integer  "bathroom",                                     default: 0
    t.integer  "balcony",                                      default: 0
    t.integer  "owner_id",                                                   null: false
    t.date     "available_date"
    t.date     "reservable_date"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_index "houses", ["owner_id"], name: "index_houses_on_owner_id", using: :btree

  create_table "pins", force: :cascade do |t|
    t.string   "content"
    t.integer  "sms_confirmable_id"
    t.string   "sms_confirmable_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "pins", ["sms_confirmable_type", "sms_confirmable_id"], name: "index_pins_on_sms_confirmable_type_and_sms_confirmable_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "password_digest"
    t.boolean  "verified",          default: false
    t.date     "start_school_year"
    t.integer  "school_id"
    t.string   "provider"
    t.string   "email"
    t.string   "uid"
    t.boolean  "sign_with_zuker"
    t.string   "image"
    t.string   "fb_url"
    t.string   "location"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "users", ["phone_number"], name: "index_users_on_phone_number", using: :btree
  add_index "users", ["school_id"], name: "index_users_on_school_id", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  add_foreign_key "attachments", "houses"
  add_foreign_key "users", "schools"
end
