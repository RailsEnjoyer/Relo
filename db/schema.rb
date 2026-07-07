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

ActiveRecord::Schema[8.1].define(version: 2026_07_06_205119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.decimal "average_buy_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "average_rent_price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "cost_of_living_index"
    t.datetime "created_at", null: false
    t.integer "crime_index"
    t.text "description"
    t.boolean "has_water_access", default: false, null: false
    t.string "major_industries", default: [], array: true
    t.string "name", null: false
    t.string "natural_disasters", default: [], array: true
    t.integer "population"
    t.bigint "state_id", null: false
    t.datetime "updated_at", null: false
    t.integer "walkability_score"
    t.index ["state_id", "name"], name: "index_cities_on_state_id_and_name", unique: true
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "listing_amenities", force: :cascade do |t|
    t.bigint "amenity_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "listing_id", null: false
    t.float "quantity", default: 0.0
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_listing_amenities_on_amenity_id"
    t.index ["listing_id", "amenity_id"], name: "index_listing_amenities_on_listing_id_and_amenity_id", unique: true
    t.index ["listing_id"], name: "index_listing_amenities_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "address"
    t.date "available_from"
    t.decimal "bathrooms", precision: 3, scale: 1
    t.integer "bedrooms"
    t.decimal "buy_price", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.string "image_urls", default: [], array: true
    t.string "landlord_contact"
    t.datetime "last_synced_at"
    t.float "latitude"
    t.float "longitude"
    t.bigint "neighborhood_id"
    t.integer "offer_type", default: 0, null: false
    t.integer "property_type", default: 0, null: false
    t.integer "rating"
    t.jsonb "raw_payload", default: {}
    t.decimal "rent_price", precision: 10, scale: 2, default: "0.0"
    t.integer "sqft"
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.boolean "with_animals", default: false, null: false
    t.index ["neighborhood_id"], name: "index_listings_on_neighborhood_id"
    t.index ["offer_type"], name: "index_listings_on_offer_type"
    t.index ["url"], name: "index_listings_on_url", unique: true
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.decimal "average_buy_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "average_rent_price", precision: 10, scale: 2, default: "0.0", null: false
    t.bigint "city_id", null: false
    t.integer "cost_of_living_index"
    t.datetime "created_at", null: false
    t.integer "crime_index"
    t.text "description"
    t.string "name", null: false
    t.float "school_rating"
    t.string "tags", default: [], array: true
    t.datetime "updated_at", null: false
    t.integer "walkability_score"
    t.index ["city_id", "name"], name: "index_neighborhoods_on_city_id_and_name", unique: true
    t.index ["city_id"], name: "index_neighborhoods_on_city_id"
  end

  create_table "relocation_plans", force: :cascade do |t|
    t.integer "bathrooms"
    t.integer "bedrooms"
    t.decimal "buy_budget", precision: 10, scale: 2
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.string "deal_breakers", default: [], array: true
    t.text "description"
    t.float "latitude"
    t.float "longitude"
    t.decimal "monthly_rent_budget", precision: 10, scale: 2
    t.datetime "move_date"
    t.string "must_haves", default: [], array: true
    t.bigint "neighborhood_id"
    t.integer "people_count", default: 1, null: false
    t.string "priorities", default: [], array: true
    t.string "property_type"
    t.integer "sqft"
    t.bigint "state_id"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "with_animals", default: false, null: false
    t.index ["city_id"], name: "index_relocation_plans_on_city_id"
    t.index ["neighborhood_id"], name: "index_relocation_plans_on_neighborhood_id"
    t.index ["state_id"], name: "index_relocation_plans_on_state_id"
    t.index ["title"], name: "index_relocation_plans_on_title"
    t.index ["user_id"], name: "index_relocation_plans_on_user_id"
  end

  create_table "saved_listings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "listing_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["listing_id"], name: "index_saved_listings_on_listing_id"
    t.index ["user_id", "listing_id"], name: "index_saved_listings_on_user_id_and_listing_id", unique: true
    t.index ["user_id"], name: "index_saved_listings_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.decimal "average_buy_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "average_rent_price", precision: 10, scale: 2, default: "0.0", null: false
    t.string "climate_category"
    t.string "code", null: false
    t.integer "cost_of_living_index"
    t.datetime "created_at", null: false
    t.integer "crime_index"
    t.text "description"
    t.boolean "has_water_access", default: false, null: false
    t.decimal "income_tax_rate", precision: 5, scale: 2
    t.string "name", null: false
    t.string "natural_disasters", default: [], array: true
    t.integer "political_leaning", default: 0, null: false
    t.decimal "sales_tax_rate", precision: 5, scale: 2
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_states_on_code", unique: true
    t.index ["name"], name: "index_states_on_name", unique: true
  end

  create_table "user_listings", force: :cascade do |t|
    t.string "additional_image_urls", default: [], array: true
    t.date "available_from"
    t.text "cons"
    t.datetime "created_at", null: false
    t.string "landlord_contact"
    t.bigint "listing_id", null: false
    t.text "notes"
    t.text "pros"
    t.bigint "relocation_plan_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "user_rating"
    t.index ["listing_id"], name: "index_user_listings_on_listing_id"
    t.index ["relocation_plan_id", "listing_id"], name: "index_user_listings_on_relocation_plan_id_and_listing_id", unique: true
    t.index ["relocation_plan_id"], name: "index_user_listings_on_relocation_plan_id"
    t.index ["user_id"], name: "index_user_listings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.bigint "state_id"
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["state_id"], name: "index_users_on_state_id"
  end

  add_foreign_key "cities", "states"
  add_foreign_key "listing_amenities", "amenities"
  add_foreign_key "listing_amenities", "listings"
  add_foreign_key "listings", "neighborhoods"
  add_foreign_key "neighborhoods", "cities"
  add_foreign_key "relocation_plans", "cities"
  add_foreign_key "relocation_plans", "neighborhoods"
  add_foreign_key "relocation_plans", "states"
  add_foreign_key "relocation_plans", "users"
  add_foreign_key "saved_listings", "listings"
  add_foreign_key "saved_listings", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "user_listings", "listings"
  add_foreign_key "user_listings", "relocation_plans"
  add_foreign_key "user_listings", "users"
  add_foreign_key "users", "cities"
  add_foreign_key "users", "states"
end
