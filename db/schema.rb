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

ActiveRecord::Schema.define(:version => 20141031183439) do

  create_table "accounts", :id => false, :force => true do |t|
    t.string   "id",           :limit => 36
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.string   "code"
    t.string   "name"
    t.string   "type"
    t.boolean  "debit_credit"
    t.decimal  "balance",                    :precision => 10, :scale => 2
    t.decimal  "balance_b",                  :precision => 10, :scale => 2
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
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
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

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "document_lines", :force => true do |t|
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.string   "code"
    t.string   "document_number"
    t.string   "type"
    t.string   "description"
    t.date     "date"
    t.decimal  "in_quantity",     :precision => 10, :scale => 2
    t.decimal  "out_quantity",    :precision => 10, :scale => 2
    t.decimal  "price",           :precision => 10, :scale => 2
    t.decimal  "total",           :precision => 10, :scale => 2
    t.integer  "year"
    t.integer  "month"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "header_id"
    t.string   "product_id"
    t.string   "warehouse_id"
    t.string   "stock_id"
  end

  create_table "document_types", :id => false, :force => true do |t|
    t.string   "id",           :limit => 36
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.string   "description"
    t.string   "account_type"
    t.string   "stock_type"
    t.boolean  "stock"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.string   "code"
    t.string   "document_number"
    t.string   "type"
    t.string   "name"
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
    t.string   "observations"
    t.string   "due"
    t.string   "status"
    t.date     "date"
    t.date     "expire_date"
    t.decimal  "discount_percentage", :precision => 10, :scale => 2
    t.decimal  "discount_total",      :precision => 10, :scale => 2
    t.decimal  "sub_total",           :precision => 10, :scale => 2
    t.decimal  "tax",                 :precision => 10, :scale => 2
    t.decimal  "tax_total",           :precision => 10, :scale => 2
    t.decimal  "total",               :precision => 10, :scale => 2
    t.decimal  "paid_left",           :precision => 10, :scale => 2
    t.decimal  "paid",                :precision => 10, :scale => 2
    t.integer  "year"
    t.integer  "month"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "document_type_id"
    t.string   "account_id"
    t.string   "warehouse_id"
  end

  create_table "payments", :id => false, :force => true do |t|
    t.string   "id",           :limit => 36
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.string   "payment_type"
    t.string   "notes"
    t.date     "date"
    t.decimal  "amount",                     :precision => 10, :scale => 2
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.string   "header_id"
  end

  create_table "products", :id => false, :force => true do |t|
    t.string   "id",          :limit => 36
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.string   "code"
    t.string   "description"
    t.string   "units"
    t.decimal  "price",                     :precision => 10, :scale => 2
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "brand_id"
    t.string   "category_id"
  end

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "stocks", :id => false, :force => true do |t|
    t.string   "id",           :limit => 36
    t.string   "version"
    t.string   "domain"
    t.string   "username"
    t.decimal  "in_quantity",                :precision => 10, :scale => 0
    t.decimal  "out_quantity",               :precision => 10, :scale => 0
    t.decimal  "stock",                      :precision => 10, :scale => 0
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.string   "product_id"
    t.string   "warehouse_id"
  end

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

  create_table "warehouses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
