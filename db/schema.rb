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

ActiveRecord::Schema.define(version: 20160930204837) do

  create_table "authorizations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "long_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contact_logs", force: :cascade do |t|
    t.boolean  "was_sent",                   default: false
    t.string   "user_email",   limit: 255
    t.string   "workplace",    limit: 255
    t.string   "distribution", limit: 255
    t.text     "message",      limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "name",         limit: 255
  end

  create_table "contents", force: :cascade do |t|
    t.integer  "offering_id",  limit: 4
    t.string   "content_url",  limit: 255
    t.string   "title",        limit: 255
    t.text     "description",  limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "position",     limit: 4,     default: 1
    t.boolean  "is_active",                  default: false
    t.string   "content_type", limit: 255
  end

  create_table "escents", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.integer  "position",    limit: 4,   default: 1
    t.string   "escent_type", limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "is_active",               default: false
  end

  create_table "offering_images", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "url",                limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "offering_id",        limit: 4
    t.boolean  "is_carousel_img",                  default: false
    t.integer  "display_position",   limit: 4,     default: 1
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.boolean  "is_active",                        default: false
    t.text     "description",        limit: 65535
    t.boolean  "is_header",                        default: false
    t.boolean  "is_head"
  end

  create_table "offering_user_povs", force: :cascade do |t|
    t.integer  "offering_id", limit: 4
    t.integer  "user_pov_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "offering_user_povs", ["offering_id"], name: "index_offering_user_povs_on_offering_id", using: :btree
  add_index "offering_user_povs", ["user_pov_id"], name: "index_offering_user_povs_on_user_pov_id", using: :btree

  create_table "offerings", force: :cascade do |t|
    t.string  "name",             limit: 255
    t.text    "brief",            limit: 65535
    t.text    "description",      limit: 65535
    t.integer "display_position", limit: 4,     default: 999
    t.integer "parent_id",        limit: 4
    t.boolean "is_visible",                     default: false
    t.string  "offering_type",    limit: 1,     default: "O"
    t.date    "expire_date"
  end

  create_table "stats", force: :cascade do |t|
    t.integer  "offering_id", limit: 4
    t.integer  "stat",        limit: 4
    t.string   "name",        limit: 255
    t.integer  "position",    limit: 4
    t.boolean  "is_active"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "user_authorizations", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "authorization_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_authorizations", ["authorization_id"], name: "index_user_authorizations_on_authorization_id", using: :btree
  add_index "user_authorizations", ["user_id"], name: "index_user_authorizations_on_user_id", using: :btree

  create_table "user_bios", force: :cascade do |t|
    t.text     "history",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "education",  limit: 65535
    t.string   "brief",      limit: 255,   default: ""
    t.string   "passion",    limit: 255,   default: ""
  end

  add_index "user_bios", ["user_id"], name: "index_user_bios_on_user_id", using: :btree

  create_table "user_classes", force: :cascade do |t|
    t.string   "abbrev",      limit: 8
    t.string   "name",        limit: 30
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "user_povs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "user_povs", ["user_id"], name: "index_user_povs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "title",            limit: 255
    t.string   "password_digest",  limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "email",            limit: 255
    t.string   "picture",          limit: 255
    t.integer  "user_class_id",    limit: 4
    t.string   "contactee",        limit: 255, default: "No"
    t.integer  "display_position", limit: 4,   default: 9999
    t.string   "prefix",           limit: 255
    t.boolean  "is_emailee",                   default: false
    t.boolean  "is_active",                    default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  add_foreign_key "offering_user_povs", "offerings"
  add_foreign_key "offering_user_povs", "user_povs"
  add_foreign_key "user_authorizations", "authorizations"
  add_foreign_key "user_authorizations", "users"
  add_foreign_key "user_bios", "users"
  add_foreign_key "user_povs", "users"
end
