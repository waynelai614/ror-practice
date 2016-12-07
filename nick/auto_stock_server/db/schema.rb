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

ActiveRecord::Schema.define(version: 20161207142513) do

  create_table "turnovers", force: :cascade do |t|
    t.string   "stock_number"
    t.string   "stock_name"
    t.float    "stock_opening_price"
    t.float    "stock_highest_price"
    t.float    "stock_floor_price"
    t.float    "stock_closing_yesterday"
    t.float    "stock_closing_today"
    t.string   "stock_volumn"
    t.float    "stock_change"
    t.string   "stock_quote_change"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
