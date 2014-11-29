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

ActiveRecord::Schema.define(version: 20141129201753) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["invitation_token"], name: "index_admins_on_invitation_token", unique: true, using: :btree
  add_index "admins", ["invitations_count"], name: "index_admins_on_invitations_count", using: :btree
  add_index "admins", ["invited_by_id"], name: "index_admins_on_invited_by_id", using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "criteria", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "judge_categories", force: true do |t|
    t.integer  "judge_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "judge_categories", ["category_id"], name: "index_judge_categories_on_category_id", using: :btree
  add_index "judge_categories", ["judge_id"], name: "index_judge_categories_on_judge_id", using: :btree

  create_table "judges", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "tamu"
    t.string   "preference"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "judges", ["email"], name: "index_judges_on_email", unique: true, using: :btree

  create_table "students", force: true do |t|
    t.string   "uin"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true, using: :btree
  add_index "students", ["uin"], name: "index_students_on_uin", unique: true, using: :btree

  create_table "video_ratings", force: true do |t|
    t.integer  "video_id"
    t.integer  "judge_id"
    t.integer  "criteria_id"
    t.decimal  "score",       precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "video_ratings", ["criteria_id"], name: "index_video_ratings_on_criteria_id", using: :btree
  add_index "video_ratings", ["judge_id"], name: "index_video_ratings_on_judge_id", using: :btree
  add_index "video_ratings", ["video_id"], name: "index_video_ratings_on_video_id", using: :btree

  create_table "videos", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "category_id"
    t.integer  "student_id"
    t.integer  "length"
    t.string   "file_size"
    t.string   "file_type"
    t.datetime "upload_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["category_id"], name: "index_videos_on_category_id", using: :btree
  add_index "videos", ["student_id"], name: "index_videos_on_student_id", using: :btree
  add_index "videos", ["url"], name: "index_videos_on_url", unique: true, using: :btree

end
