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

ActiveRecord::Schema.define(version: 20171001064708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.boolean  "availability"
    t.string   "isbn"
    t.string   "country"
    t.string   "loc"
    t.text     "tags"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "books", ["user_id"], name: "index_books_on_user_id", using: :btree

  create_table "books_booktags", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "booktag_id"
  end

  add_index "books_booktags", ["book_id"], name: "index_books_booktags_on_book_id", using: :btree
  add_index "books_booktags", ["booktag_id"], name: "index_books_booktags_on_booktag_id", using: :btree

  create_table "booktags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matcheds", force: :cascade do |t|
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "matcheds", ["book_id"], name: "index_matcheds_on_book_id", using: :btree

  create_table "matcheds_users", id: false, force: :cascade do |t|
    t.integer "matched_id"
    t.integer "user_id"
  end

  add_index "matcheds_users", ["matched_id"], name: "index_matcheds_users_on_matched_id", using: :btree
  add_index "matcheds_users", ["user_id"], name: "index_matcheds_users_on_user_id", using: :btree

  create_table "stats", force: :cascade do |t|
    t.string   "name"
    t.hstore   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wanteds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.text     "wantreason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "books", "users"
  add_foreign_key "books_booktags", "books"
  add_foreign_key "books_booktags", "booktags"
  add_foreign_key "matcheds", "books"
  add_foreign_key "matcheds_users", "matcheds"
  add_foreign_key "matcheds_users", "users"
  add_foreign_key "wanteds", "books"
  add_foreign_key "wanteds", "users"
end
