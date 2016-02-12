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

ActiveRecord::Schema.define(version: 20160211205027) do

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

  create_table "contents", force: :cascade do |t|
    t.integer  "offering_id"
    t.string   "content_url"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "position",     default: 1
    t.boolean  "is_active",    default: false
    t.string   "content_type"
  end

  create_table "escents", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "position",    default: 1
    t.string   "escent_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "is_active",   default: false
  end

  create_table "offering_images", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "offering_id"
    t.boolean  "is_carousel_img",    default: false
    t.integer  "display_position",   default: 1
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "is_active",          default: false
    t.text     "description"
  end

  create_table "offering_user_povs", force: :cascade do |t|
    t.integer  "offering_id"
    t.integer  "user_pov_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "offering_user_povs", ["offering_id"], name: "index_offering_user_povs_on_offering_id"
  add_index "offering_user_povs", ["user_pov_id"], name: "index_offering_user_povs_on_user_pov_id"

  create_table "offerings", force: :cascade do |t|
    t.string  "name"
    t.text    "brief"
    t.text    "description"
    t.integer "display_position",           default: 999
    t.integer "parent_id"
    t.boolean "is_visible",                 default: false
    t.string  "offering_type",    limit: 1, default: "O"
    t.date    "expire_date"
  end

  create_table "stats", force: :cascade do |t|
    t.integer  "offering_id"
    t.integer  "stat"
    t.string   "name"
    t.integer  "position"
    t.boolean  "is_active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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

  create_table "user_povs", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_povs", ["user_id"], name: "index_user_povs_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "password_digest"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "email"
    t.string   "picture"
    t.integer  "user_class_id"
    t.string   "contactee",        default: "No"
    t.integer  "display_position", default: 9999
    t.string   "prefix"
    t.boolean  "is_emailee",       default: false
  end

  add_index "users", ["email"], name: "index_users_on_email"

end
