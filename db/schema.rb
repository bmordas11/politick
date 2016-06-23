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

ActiveRecord::Schema.define(version: 20160623032645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comment_votes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.boolean  "user_vote",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "comment_id", null: false
  end

  add_index "comment_votes", ["user_id"], name: "index_comment_votes_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body",          default: "(No comment)", null: false
    t.integer  "rating",                                 null: false
    t.integer  "politician_id",                          null: false
    t.integer  "user_id",                                null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "comments", ["politician_id"], name: "index_comments_on_politician_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "politicians", force: :cascade do |t|
    t.string   "first_name",                                    null: false
    t.string   "last_name",                                     null: false
    t.string   "political_party",                               null: false
    t.text     "stance",          default: "(No stance added)", null: false
    t.string   "place_of_birth"
    t.date     "birthday"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "user_id"
  end

  add_index "politicians", ["user_id"], name: "index_politicians_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                                null: false
    t.string   "last_name",                                 null: false
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "role",                   default: "member", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comment_votes", "users"
  add_foreign_key "comments", "politicians"
  add_foreign_key "comments", "users"
  add_foreign_key "politicians", "users"
end
