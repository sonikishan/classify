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

ActiveRecord::Schema.define(:version => 20130715060738818) do

  create_table "abuse_reports", :force => true do |t|
    t.text     "message"
    t.integer  "user_id"
    t.integer  "advertisement_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "pulldown"
  end

  add_index "abuse_reports", ["advertisement_id"], :name => "index_abuse_reports_on_advertisement_id"
  add_index "abuse_reports", ["user_id"], :name => "index_abuse_reports_on_user_id"

  create_table "admins", :force => true do |t|
    t.string   "email",              :default => "", :null => false
    t.string   "encrypted_password", :default => "", :null => false
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",    :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "advertisement_characteristics", :force => true do |t|
    t.integer  "advertisement_id"
    t.integer  "characteristic_id"
    t.string   "value"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "advertisement_images", :force => true do |t|
    t.integer  "advertisement_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "advertisement_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "advertisements", :force => true do |t|
    t.string   "title"
    t.integer  "price"
    t.text     "values_xml"
    t.integer  "advertisement_status_id"
    t.boolean  "paid"
    t.boolean  "deleted"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "approved",                :default => true
    t.float    "min_price"
    t.float    "max_price"
  end

  add_index "advertisements", ["category_id"], :name => "index_advertisements_on_category_id"
  add_index "advertisements", ["user_id"], :name => "index_advertisements_on_user_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bids", :force => true do |t|
    t.integer  "price"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.integer  "user_id"
    t.integer  "advertisement_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "bids", ["advertisement_id"], :name => "index_bids_on_advertisement_id"
  add_index "bids", ["user_id"], :name => "index_bids_on_user_id"

  create_table "blocked_ips", :force => true do |t|
    t.integer  "user_id"
    t.string   "ip_address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "parent_id"
    t.boolean  "active_status", :default => true
  end

  create_table "category_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "category_hierarchies", ["ancestor_id", "descendant_id"], :name => "index_category_hierarchies_on_ancestor_id_and_descendant_id", :unique => true
  add_index "category_hierarchies", ["descendant_id"], :name => "index_category_hierarchies_on_descendant_id"

  create_table "characteristics", :force => true do |t|
    t.string   "name"
    t.string   "input_kind"
    t.text     "default_values"
    t.integer  "category_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "multiselect",    :default => false
  end

  add_index "characteristics", ["category_id"], :name => "index_characteristics_on_category_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "contacts", :force => true do |t|
    t.integer  "advertisement_id"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "phone"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "advertisement_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "favorites", ["advertisement_id"], :name => "index_favorites_on_advertisement_id"
  add_index "favorites", ["user_id"], :name => "index_favorites_on_user_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "rating_caches", :force => true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            :null => false
    t.integer  "qty",            :null => false
    t.string   "dimension"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], :name => "index_rating_caches_on_cacheable_id_and_cacheable_type"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.string   "salutation"
    t.string   "address"
    t.string   "zipcode"
    t.string   "city"
    t.string   "province"
    t.string   "phone"
    t.string   "url"
    t.integer  "longitude"
    t.integer  "latitude"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "block_user",             :default => false
    t.string   "role"
    t.boolean  "account_active",         :default => true
    t.boolean  "block_ip",               :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "view_counts", :force => true do |t|
    t.integer  "amount"
    t.integer  "advertisement_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "view_counts", ["advertisement_id"], :name => "index_view_counts_on_advertisement_id"

end
