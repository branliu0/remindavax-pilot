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

ActiveRecord::Schema.define(:version => 20110623055735) do

  create_table "anms", :force => true do |t|
    t.string   "name"
    t.string   "mobile"
    t.integer  "phc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointment_types", :force => true do |t|
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "appointment_type_id"
  end

  create_table "appointments", :force => true do |t|
    t.integer  "patient_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "appointment_type_id"
  end

  create_table "patients", :force => true do |t|
    t.string   "name"
    t.string   "encrypted_mobile"
    t.string   "encrypted_cell_access"
    t.integer  "phc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "receiving_texts"
    t.string   "encrypted_expected_delivery_date"
    t.string   "encrypted_husband_name"
    t.string   "encrypted_caste"
    t.string   "encrypted_taayi_card_number"
    t.string   "encrypted_subcenter"
    t.string   "encrypted_mother_age"
    t.string   "encrypted_education"
    t.string   "encrypted_delivery_place"
    t.integer  "anm_id"
    t.string   "encrypted_ec_number"
  end

  create_table "phcs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.integer  "phc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visits", :force => true do |t|
    t.integer  "patient_id"
    t.date     "date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
