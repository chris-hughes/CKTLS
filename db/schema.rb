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

ActiveRecord::Schema.define(:version => 20121027132926) do

  create_table "cocktails", :force => true do |t|
    t.string   "name"
    t.string   "family"
    t.integer  "makes"
    t.string   "glass"
    t.boolean  "chilled",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "cocktails", ["name"], :name => "index_cocktails_on_name", :unique => true

  create_table "directions", :force => true do |t|
    t.integer  "cocktail_id"
    t.text     "direction"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ingredients", :force => true do |t|
    t.integer  "cocktail_id"
    t.string   "ingredient"
    t.integer  "measure"
    t.string   "unit"
    t.boolean  "decoration",  :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "tools", :force => true do |t|
    t.integer  "cocktail_id"
    t.string   "tool"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "cocktail_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "votes", ["cocktail_id"], :name => "index_votes_on_cocktail_id"
  add_index "votes", ["user_id", "cocktail_id"], :name => "index_votes_on_user_id_and_cocktail_id", :unique => true
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
