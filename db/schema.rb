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

ActiveRecord::Schema.define(:version => 20140408103342) do

  create_table "accounts", :id => false, :force => true do |t|
    t.string   "id",           :limit => 36
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.string   "code"
    t.string   "name"
    t.string   "type"
    t.boolean  "debit_credit"
    t.decimal  "balance"
    t.decimal  "balance_b"
    t.string   "id_number1"
    t.string   "id_number2"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip_code"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "web"
    t.string   "contact"
    t.string   "observations"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "brands", :id => false, :force => true do |t|
    t.string   "id",          :limit => 36
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "categories", :id => false, :force => true do |t|
    t.string   "id",          :limit => 36
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "companies", :id => false, :force => true do |t|
    t.string   "id",                :limit => 36
    t.string   "name"
    t.string   "address"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "products", :id => false, :force => true do |t|
    t.string   "id",          :limit => 36
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.string   "code"
    t.string   "description"
    t.string   "units"
    t.decimal  "price"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "brand_id"
    t.string   "category_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "username",               :default => "", :null => false
    t.string   "company_name",           :default => "", :null => false
    t.string   "domain",                 :default => "", :null => false
    t.string   "name",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
