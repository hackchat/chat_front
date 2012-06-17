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

ActiveRecord::Schema.define(:version => 20120617054955) do

  create_table "messages", :force => true do |t|
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "room_id"
    t.string   "language"
    t.string   "user_token"
    t.string   "avatar"
    t.string   "name"
  end

  add_index "messages", ["room_id"], :name => "index_messages_on_room_id"

  create_table "roomies", :force => true do |t|
    t.string   "user_token"
    t.integer  "room_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "avatar"
    t.string   "status"
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_token"
  end

  create_table "uploads", :force => true do |t|
    t.string   "url"
    t.integer  "room_id"
    t.string   "user_token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "file_name"
  end

end
