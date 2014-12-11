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

ActiveRecord::Schema.define(version: 20141211010300) do

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

  create_table "judge_contestants", force: true do |t|
    t.integer  "judge_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "judge_contestants", ["judge_id"], name: "index_judge_contestants_on_judge_id", using: :btree
  add_index "judge_contestants", ["student_id"], name: "index_judge_contestants_on_student_id", using: :btree

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
    t.integer  "score"
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
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.text     "video_meta"
  end

  add_index "videos", ["category_id"], name: "index_videos_on_category_id", using: :btree
  add_index "videos", ["student_id"], name: "index_videos_on_student_id", using: :btree
  add_index "videos", ["url"], name: "index_videos_on_url", unique: true, using: :btree

end
