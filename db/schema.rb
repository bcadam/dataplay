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

ActiveRecord::Schema.define(version: 20140310222653) do

  create_table "companies", force: true do |t|
    t.string  "name"
    t.string  "cik"
    t.string  "industry"
    t.integer "filing_id"
  end

  create_table "filings", force: true do |t|
    t.integer  "company_id"
    t.string   "title"
    t.string   "url"
    t.string   "links"
    t.string   "summary"
    t.datetime "updated"
    t.string   "categories"
    t.string   "file_id"
    t.string   "file_serial"
    t.string   "cik"
    t.text     "filingtext"
    t.string   "stockticker"
    t.text     "footnote"
    t.date     "periodofreport"
    t.string   "irsnumber"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "watch_lists", force: true do |t|
    t.string   "name"
    t.string   "companycik"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
