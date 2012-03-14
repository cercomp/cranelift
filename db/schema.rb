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

ActiveRecord::Schema.define(:version => 20120208154052) do

  create_table "ips", :force => true do |t|
    t.string   "ip"
    t.string   "cidr"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "project_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "repositories", :force => true do |t|
    t.integer  "project_id"
    t.string   "url"
    t.boolean  "enable_autoupdate"
    t.string   "autoupdate_login"
    t.string   "autoupdate_password"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "admin"
    t.boolean  "ip_block"
    t.datetime "last_action"
    t.string   "name"
    t.string   "email"
    t.boolean  "active"
    t.string   "login_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
