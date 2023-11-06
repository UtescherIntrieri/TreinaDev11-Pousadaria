# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_06_003830) do
  create_table "adjusted_prices", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "price"
    t.integer "room_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inn_id", default: 0, null: false
    t.index ["inn_id"], name: "index_adjusted_prices_on_inn_id"
    t.index ["room_id"], name: "index_adjusted_prices_on_room_id"
  end

  create_table "hosts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_hosts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_hosts_on_reset_password_token", unique: true
  end

  create_table "inns", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "registration_number"
    t.string "phone_number"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "description"
    t.string "payment_methods"
    t.boolean "pet_friendly"
    t.string "usage_policy"
    t.time "check_in"
    t.time "check_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 2
    t.integer "host_id", default: 0, null: false
    t.index ["host_id"], name: "index_inns_on_host_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "dimension"
    t.integer "capacity"
    t.integer "price"
    t.boolean "bathroom"
    t.boolean "balcony"
    t.boolean "ac"
    t.boolean "tv"
    t.boolean "wardrobre"
    t.boolean "safe_box"
    t.boolean "accessible"
    t.integer "status", default: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inn_id", default: 0, null: false
    t.index ["inn_id"], name: "index_rooms_on_inn_id"
  end

  add_foreign_key "adjusted_prices", "inns"
  add_foreign_key "adjusted_prices", "rooms"
  add_foreign_key "inns", "hosts"
  add_foreign_key "rooms", "inns"
end
