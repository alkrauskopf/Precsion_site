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

ActiveRecord::Schema.define(version: 20150823175316) do

  create_table "authorizations", force: :cascade do |t|
    t.string   "name"
    t.string   "long_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_logs", force: :cascade do |t|
    t.boolean  "was_sent",     default: false
    t.string   "user_email"
    t.string   "workplace"
    t.string   "distribution"
    t.text     "message"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name"
  end

  create_table "user_authorizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "authorization_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "user_authorizations", ["authorization_id"], name: "index_user_authorizations_on_authorization_id"
  add_index "user_authorizations", ["user_id"], name: "index_user_authorizations_on_user_id"

  create_table "user_bios", force: :cascade do |t|
    t.text     "history"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "education",  default: ""
    t.string   "brief",      default: ""
    t.string   "passion",    default: ""
  end

  add_index "user_bios", ["user_id"], name: "index_user_bios_on_user_id"

  create_table "user_classes", force: :cascade do |t|
    t.string   "abbrev",      limit: 8
    t.string   "name",        limit: 30
    t.text     "description"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "email"
    t.string   "picture"
    t.boolean  "is_contactee",    default: false
    t.integer  "user_class_id"
  end

  add_index "users", ["email"], name: "index_users_on_email"

end
