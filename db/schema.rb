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

ActiveRecord::Schema[7.0].define(version: 2024_08_28_102318) do
  create_table "deliveries", force: :cascade do |t|
    t.integer "order_id", null: false
    t.datetime "scheduled_date"
    t.datetime "delivery_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.integer "delivery_cost"
    t.index ["order_id"], name: "index_deliveries_on_order_id"
    t.index ["status"], name: "index_deliveries_on_status"
  end

  create_table "expenses", force: :cascade do |t|
    t.text "description"
    t.decimal "amount"
    t.datetime "expense_date"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "scheduled_date"
    t.datetime "reminder_date"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "message"
    t.datetime "notification_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "order_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.integer "quantity"
    t.decimal "price"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price"
    t.decimal "cost"
    t.integer "stock_level"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "user_id", null: false
    t.integer "quantity"
    t.decimal "total_price"
    t.datetime "sale_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delivery_id"
    t.integer "order_id"
    t.decimal "commission", precision: 10, scale: 2, default: "0.0"
    t.decimal "final_price", precision: 10, scale: 2, default: "0.0"
    t.index ["delivery_id"], name: "index_sales_on_delivery_id"
    t.index ["order_id"], name: "index_sales_on_order_id"
    t.index ["product_id"], name: "index_sales_on_product_id"
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "email"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "deliveries", "orders"
  add_foreign_key "notifications", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "sales", "deliveries"
  add_foreign_key "sales", "orders"
  add_foreign_key "sales", "products"
  add_foreign_key "sales", "users"
end
