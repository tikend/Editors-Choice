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

ActiveRecord::Schema.define(:version => 20130613135012) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "microposts", :force => true do |t|
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.text     "url"
    t.text     "author"
    t.text     "title"
    t.text     "picture"
    t.text     "description"
    t.integer  "count",       :default => 0
    t.integer  "server_id"
    t.string   "category"
  end

  add_index "microposts", ["created_at"], :name => "index_microposts_on_created_at"
  add_index "microposts", ["id"], :name => "microposts_id_idx"

  create_table "posttags", :force => true do |t|
    t.integer  "micropost_id"
    t.integer  "tag_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "servers", :force => true do |t|
    t.text     "url"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tagcategories", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "userposts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "micropost_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "userposts", ["id"], :name => "userposts_id_idx"
  add_index "userposts", ["micropost_id"], :name => "index_userposts_on_micropost_id"
  add_index "userposts", ["user_id"], :name => "index_userposts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.string   "category"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["id"], :name => "user_id_idx"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
