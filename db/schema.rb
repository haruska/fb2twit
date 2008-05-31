# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 4) do

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.integer  "facebook_id",                    :null => false
    t.text     "session"
    t.string   "twitter_name"
    t.string   "twitter_pass"
    t.string   "last_status"
    t.boolean  "bad_pass"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "remove_is",    :default => true, :null => false
    t.string   "ignore"
    t.string   "pretext"
  end

  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id", :unique => true

end
