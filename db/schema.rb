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

ActiveRecord::Schema[7.1].define(version: 2023_11_01_164036) do
  create_table "inns", force: :cascade do |t|
    t.string "corporate_names"
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
  end

end
