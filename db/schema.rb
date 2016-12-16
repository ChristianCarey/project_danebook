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

ActiveRecord::Schema.define(version: 20161215233548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "author_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "likings_count"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  end

  create_table "friendings", force: :cascade do |t|
    t.integer  "friender_id"
    t.integer  "friended_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true, using: :btree
  end

  create_table "likings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "likable_type"
    t.integer  "likable_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["likable_type", "likable_id"], name: "index_likings_on_likable_type_and_likable_id", using: :btree
    t.index ["user_id", "likable_id", "likable_type"], name: "index_likings_on_user_id_and_likable_id_and_likable_type", unique: true, using: :btree
    t.index ["user_id"], name: "index_likings_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "author_id"
    t.integer  "likings_count"
  end

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "likings_count"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "birthday"
    t.string   "college"
    t.string   "hometown"
    t.string   "current_location"
    t.string   "phone"
    t.text     "about_me"
    t.text     "tagline"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "password_digest",  null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "auth_token"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "profile_photo_id"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "likings", "users"
  add_foreign_key "profiles", "users"
end
