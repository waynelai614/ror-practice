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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20170302022828) do

  create_table "turnovers", :force => true do |t|
    t.integer  "stock_code"
    t.string   "stock_name"
    t.string   "stock_company_uri"
    t.float    "stock_opening_price"
    t.float    "stock_highest_price"
    t.float    "stock_lowest_price"
    t.float    "stock_closing_yesterday"
    t.float    "stock_closing_today"
    t.integer  "stock_volume"
    t.float    "stock_change"
    t.float    "stock_quote_change"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

end
