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

ActiveRecord::Schema.define(:version => 20121107193644) do

  create_table "ips", :force => true do |t|
    t.string   "ip"
    t.string   "cidr"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "controller"
    t.string   "action"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "controller"
    t.string   "actions"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "permissions_roles", :id => false, :force => true do |t|
    t.integer "permission_id"
    t.integer "role_id"
  end

  add_index "permissions_roles", ["permission_id", "role_id"], :name => "index_permissions_roles_on_permission_id_and_role_id", :unique => true

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "projects", ["slug"], :name => "index_projects_on_slug", :unique => true

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "projects_users", ["project_id", "user_id"], :name => "index_projects_users_on_project_id_and_user_id", :unique => true

  create_table "repositories", :force => true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.string   "slug"
    t.string   "url"
    t.string   "login"
    t.string   "password"
    t.boolean  "enable_autoupdate", :default => true
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "repositories", ["slug"], :name => "index_repositories_on_slug", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "admin",                  :default => false
    t.integer  "role_id"
    t.boolean  "ip_block",               :default => true
    t.datetime "last_action"
    t.string   "email"
    t.boolean  "active",                 :default => false
    t.string   "login_type"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "first_name"
    t.string   "last_name"
  end

end
