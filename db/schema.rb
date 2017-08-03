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

ActiveRecord::Schema.define(version: 20170803191519) do

  create_table "authorizations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "long_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "captcha_images", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
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
    t.integer  "offering_id",                  limit: 4
    t.string   "content_url",                  limit: 255
    t.string   "title",                        limit: 255
    t.text     "description",                  limit: 65535
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.integer  "position",                     limit: 4,     default: 1
    t.boolean  "is_active",                                  default: false
    t.string   "content_type",                 limit: 255
    t.string   "attached_report_file_name",    limit: 255
    t.string   "attached_report_content_type", limit: 255
    t.integer  "attached_report_file_size",    limit: 4
    t.datetime "attached_report_updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "escents", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.integer  "position",    limit: 4,   default: 1
    t.string   "escent_type", limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "is_active",               default: false
  end

  create_table "events", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "capacity",      limit: 4
    t.integer  "price_cents",   limit: 8
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "venue_id",      limit: 4
    t.text     "location",      limit: 65535
    t.text     "time",          limit: 65535
    t.boolean  "is_active",                   default: true
    t.integer  "e_type",        limit: 4,     default: 0
    t.string   "message",       limit: 255,   default: ""
    t.string   "name",          limit: 255
    t.string   "contact_name",  limit: 255
    t.string   "contact_email", limit: 255
    t.string   "terms_for",     limit: 255
  end

  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

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

  create_table "offering_logs", force: :cascade do |t|
    t.integer  "offering_id", limit: 4
    t.text     "period",      limit: 65535
    t.integer  "counter",     limit: 4,     default: 1
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "offering_logs", ["offering_id"], name: "index_offering_logs_on_offering_id", using: :btree

  create_table "offering_testimonies", force: :cascade do |t|
    t.integer  "offering_id",  limit: 4
    t.integer  "testimony_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "offering_testimonies", ["offering_id"], name: "index_offering_testimonies_on_offering_id", using: :btree
  add_index "offering_testimonies", ["testimony_id"], name: "index_offering_testimonies_on_testimony_id", using: :btree

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
    t.string  "offering_type",    limit: 2,     default: "O"
    t.date    "expire_date"
    t.string  "panel_header",     limit: 255
    t.string  "panel_color",      limit: 255,   default: "transparent"
    t.string  "tst_person_name",  limit: 255
    t.string  "tst_person_role",  limit: 255
    t.text    "tst_statement",    limit: 65535
    t.string  "tst_view_label",   limit: 255,   default: "Customer Feedback"
    t.text    "tst_video",        limit: 65535
    t.string  "tst_topic",        limit: 255
    t.string  "tst_organization", limit: 255
    t.boolean "is_default",                     default: false
  end

  create_table "pay_terms", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "terms",      limit: 65535
    t.boolean  "is_active",                default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "e_type",     limit: 4,     default: 0
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "buyable_id",     limit: 4
    t.integer  "price_cents",    limit: 4,     default: 0,     null: false
    t.string   "price_currency", limit: 255,   default: "USD", null: false
    t.integer  "status",         limit: 4
    t.string   "payment_method", limit: 255
    t.string   "response_id",    limit: 255
    t.text     "full_response",  limit: 65535
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "description",    limit: 255
    t.string   "reference",      limit: 255
    t.string   "buyable_type",   limit: 255
  end

  add_index "payments", ["buyable_id"], name: "index_payments_on_buyable_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "event_id",     limit: 4
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "email",        limit: 255
    t.integer  "status",       limit: 4,     default: 0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.text     "notes",        limit: 65535
    t.boolean  "was_notified",               default: false
    t.string   "enrollment",   limit: 255
    t.string   "phone",        limit: 13
    t.string   "school",       limit: 255
    t.integer  "price_cents",  limit: 4,     default: 0
  end

  add_index "reservations", ["enrollment"], name: "index_reservations_on_enrollment", unique: true, using: :btree
  add_index "reservations", ["event_id"], name: "index_reservations_on_event_id", using: :btree

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
    t.string   "passion",    limit: 255,   default: ""
    t.text     "brief",      limit: 65535
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
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "label",      limit: 15
    t.boolean  "is_active",              default: true
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
    t.boolean  "is_p_emailee",                 default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",       limit: 64
    t.text     "notes",      limit: 65535
    t.boolean  "is_active",                default: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "abbrev",     limit: 4
  end

  add_foreign_key "offering_user_povs", "offerings"
  add_foreign_key "offering_user_povs", "user_povs"
  add_foreign_key "user_authorizations", "authorizations"
  add_foreign_key "user_authorizations", "users"
  add_foreign_key "user_bios", "users"
  add_foreign_key "user_povs", "users"
end
