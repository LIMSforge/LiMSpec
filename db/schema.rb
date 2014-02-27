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

ActiveRecord::Schema.define(:version => 20140226061236) do

  create_table "app_settings", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "showIndustry"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "authentications", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "catName"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "catAbbr"
  end

  create_table "identities", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "uid"
  end

  create_table "ind_questions", :force => true do |t|
    t.integer  "industry_id"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ind_requirements", :force => true do |t|
    t.integer  "industry_id"
    t.integer  "requirement_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "ind_user_questions", :force => true do |t|
    t.integer  "industry_id"
    t.integer  "user_question_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "ind_user_requirements", :force => true do |t|
    t.integer  "user_requirement_id"
    t.integer  "industry_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "ind_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "industry_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "industries", :force => true do |t|
    t.string   "indName"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "oauth_access_grants", :force => true do |t|
    t.integer  "resource_owner_id", :null => false
    t.integer  "application_id",    :null => false
    t.string   "token",             :null => false
    t.integer  "expires_in",        :null => false
    t.string   "redirect_uri",      :null => false
    t.datetime "created_at",        :null => false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], :name => "index_oauth_access_grants_on_token", :unique => true

  create_table "oauth_access_tokens", :force => true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id",    :null => false
    t.string   "token",             :null => false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        :null => false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], :name => "index_oauth_access_tokens_on_refresh_token", :unique => true
  add_index "oauth_access_tokens", ["resource_owner_id"], :name => "index_oauth_access_tokens_on_resource_owner_id"
  add_index "oauth_access_tokens", ["token"], :name => "index_oauth_access_tokens_on_token", :unique => true

  create_table "oauth_applications", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "uid",          :null => false
    t.string   "secret",       :null => false
    t.string   "redirect_uri", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "oauth_applications", ["uid"], :name => "index_oauth_applications_on_uid", :unique => true

  create_table "organizations", :force => true do |t|
    t.string   "orgName"
    t.string   "orgType"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "vendor"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "project_organizations", :force => true do |t|
    t.integer "project_id"
    t.integer "organization_id"
    t.string  "relationship"
  end

  create_table "project_users", :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.string  "relationship"
  end

  create_table "projects", :force => true do |t|
    t.string   "projectName"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "projects_users", :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  create_table "questions", :force => true do |t|
    t.string   "qTitle"
    t.text     "qText"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "source_id"
    t.integer  "version"
    t.boolean  "active"
  end

  create_table "requirements", :force => true do |t|
    t.string   "reqTitle"
    t.text     "reqText"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "category_id"
    t.string   "status"
    t.integer  "source_id"
    t.integer  "sortOrder"
    t.integer  "version"
    t.boolean  "active"
  end

  create_table "responses", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "requirement_id"
    t.integer  "question_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "role_assignments", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "roleName"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_questions", :force => true do |t|
    t.integer  "user_id"
    t.string   "qTitle"
    t.text     "qText"
    t.boolean  "userModified"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "question_id"
    t.integer  "version"
  end

  create_table "user_requirements", :force => true do |t|
    t.integer  "requirement_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "relationship"
    t.string   "req_title"
    t.text     "req_text"
    t.boolean  "userModified"
    t.integer  "category_id"
    t.integer  "position"
    t.integer  "version"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "provider"
    t.integer  "uid"
    t.string   "userFirst"
    t.string   "userLast"
    t.string   "email"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "company"
    t.string   "workPhone"
    t.boolean  "emailSystemNotify",      :default => true
    t.boolean  "emailGeneral"
    t.string   "password_digest"
  end

  create_table "vendor_clients", :force => true do |t|
    t.integer "vendor_id"
    t.integer "client_id"
  end

  create_table "vendor_requests", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
