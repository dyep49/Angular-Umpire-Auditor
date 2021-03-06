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

ActiveRecord::Schema.define(version: 20160513031001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: :cascade do |t|
    t.datetime "game_date"
    t.string   "umpire",                limit: 255
    t.string   "home_team",             limit: 255
    t.string   "away_team",             limit: 255
    t.float    "total_distance_missed"
    t.integer  "umpire_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "inning",                limit: 255
    t.integer  "ball_count"
    t.integer  "strike_count"
    t.integer  "outs"
    t.string   "inning_half",           limit: 255
    t.integer  "pitch_id"
    t.text     "play"
    t.string   "img_date",              limit: 255
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.integer  "pitcher_id"
    t.integer  "umpire_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: :cascade do |t|
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.string   "gid",              limit: 255
    t.integer  "mlb_umpire_id"
    t.integer  "umpire_id"
    t.datetime "game_date"
    t.integer  "total_calls",                  default: 0
    t.integer  "correct_calls",                default: 0
    t.integer  "incorrect_calls",              default: 0
    t.string   "home_team_abbrev", limit: 255
    t.string   "away_team_abbrev", limit: 255
    t.float    "percent_correct",              default: 0.0
    t.string   "umpire_name",      limit: 255
    t.string   "game_type",        limit: 255
    t.string   "home_full_name",   limit: 255
    t.string   "away_full_name",   limit: 255
  end

  add_index "games", ["umpire_id"], name: "index_games_on_umpire_id", using: :btree

  create_table "games_teams", force: :cascade do |t|
    t.integer "game_id"
    t.integer "team_id"
  end

  create_table "pitchers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "team",       limit: 255
    t.integer  "pid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitches", force: :cascade do |t|
    t.string   "gid",                   limit: 255
    t.datetime "date_string"
    t.string   "description",           limit: 255
    t.integer  "pid"
    t.float    "x_location"
    t.float    "y_location"
    t.float    "sz_top"
    t.float    "sz_bottom"
    t.string   "sv_id",                 limit: 255
    t.string   "type_id",               limit: 255
    t.boolean  "missing_data"
    t.boolean  "correct_call"
    t.float    "distance_missed_x",                 default: 0.0
    t.float    "distance_missed_y",                 default: 0.0
    t.float    "total_distance_missed",             default: 0.0
    t.integer  "pitcher_id"
    t.integer  "mlb_umpire_id"
    t.integer  "batter_id"
    t.integer  "game_id"
    t.integer  "ball_count"
    t.integer  "strike_count"
    t.integer  "outs"
    t.string   "inning_half",           limit: 255
    t.integer  "inning"
    t.text     "play"
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "abbreviation", limit: 255
    t.string   "full_name",    limit: 255
    t.integer  "division_id"
    t.integer  "league_id"
    t.string   "code",         limit: 255
    t.string   "city",         limit: 255
    t.string   "name_brief",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",        limit: 255
  end

  create_table "umpires", force: :cascade do |t|
    t.string  "name",          limit: 255
    t.integer "mlb_umpire_id"
  end

  add_index "umpires", ["mlb_umpire_id"], name: "my_index", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
