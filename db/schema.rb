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

ActiveRecord::Schema.define(version: 20150209015029) do

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owners", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "owners", ["email"], name: "index_owners_on_email", unique: true
  add_index "owners", ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true

  create_table "replies", force: true do |t|
    t.text     "body",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_id"
    t.integer  "owner_id"
    t.string   "current_owner_email"
    t.integer  "department_id"
    t.integer  "state_id"
  end

  add_index "replies", ["department_id"], name: "index_replies_on_department_id"
  add_index "replies", ["owner_id"], name: "index_replies_on_owner_id"
  add_index "replies", ["state_id"], name: "index_replies_on_state_id"
  add_index "replies", ["ticket_id"], name: "index_replies_on_ticket_id"

  create_table "states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.string   "client_name"
    t.string   "client_email"
    t.string   "subject"
    t.text     "body"
    t.string   "uniq_reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.integer  "state_id"
    t.integer  "owner_id"
  end

  add_index "tickets", ["department_id"], name: "index_tickets_on_department_id"
  add_index "tickets", ["owner_id"], name: "index_tickets_on_owner_id"
  add_index "tickets", ["state_id"], name: "index_tickets_on_state_id"

end
