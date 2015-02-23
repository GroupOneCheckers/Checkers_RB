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

ActiveRecord::Schema.define(version: 20150223061915) do

  create_table "games", force: :cascade do |t|
    t.integer "players_count"
    t.integer "winner_id"
    t.string  "board"
    t.boolean "finished",      default: false
  end

  create_table "players", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "bitcoin_address"
    t.string   "card_type"
    t.datetime "expirey_date"
    t.string   "card_number_last_four"
    t.string   "favorite_color"
    t.string   "blog"
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.integer  "wins",                   default: 0
    t.integer  "losses",                 default: 0
    t.integer  "forfeits",               default: 0
    t.integer  "level",                  default: 1
    t.integer  "experience",             default: 0
    t.string   "division"
    t.datetime "last_seen"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
