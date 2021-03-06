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

ActiveRecord::Schema.define(version: 20160829125155) do

  create_table "advertises", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "website_id"
  end

  add_index "advertises", ["website_id"], name: "index_advertises_on_website_id"

  create_table "dashboards", force: :cascade do |t|
    t.integer  "calls"
    t.integer  "clicks"
    t.integer  "searches"
    t.integer  "cost"
    t.integer  "budget"
    t.integer  "website_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "smartphones"
    t.integer  "tablets"
    t.integer  "computers"
  end

  add_index "dashboards", ["website_id"], name: "index_dashboards_on_website_id"

  create_table "data_dashboards", force: :cascade do |t|
    t.integer  "calls"
    t.integer  "clicks"
    t.integer  "searches"
    t.integer  "cost"
    t.integer  "budget"
    t.integer  "smartphones"
    t.integer  "tablets"
    t.integer  "computers"
    t.integer  "dashboard_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "data_dashboards", ["dashboard_id"], name: "index_data_dashboards_on_dashboard_id"

  create_table "invoices", force: :cascade do |t|
    t.string   "bill_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: :cascade do |t|
    t.decimal  "price"
    t.string   "description"
    t.integer  "quantity"
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.boolean  "delinquent"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "websites", force: :cascade do |t|
    t.string   "name"
    t.string   "product"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "product1"
    t.string   "product2"
    t.boolean  "advertising",     default: false
    t.boolean  "subscribed",      default: false
    t.string   "stripeid"
    t.date     "end_date"
    t.integer  "days_left"
    t.date     "date_subscribed"
  end

  add_index "websites", ["user_id"], name: "index_websites_on_user_id"

end
