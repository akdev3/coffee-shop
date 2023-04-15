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

ActiveRecord::Schema[7.0].define(version: 2023_04_08_235854) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_deals", id: false, force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "group_item_id"
    t.index ["group_item_id"], name: "index_group_deals_on_group_item_id"
    t.index ["item_id", "group_item_id"], name: "index_group_deals_on_item_id_and_group_item_id", unique: true
    t.index ["item_id"], name: "index_group_deals_on_item_id"
  end

  create_table "group_items", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.decimal "disc_amount", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.decimal "price", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "group_item_id"
    t.bigint "promotion_line_item_id"
    t.bigint "order_id", null: false
    t.integer "quantity", default: 1, null: false
    t.decimal "price", default: "0.0", null: false
    t.decimal "disc", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_item_id"], name: "index_line_items_on_group_item_id"
    t.index ["item_id"], name: "index_line_items_on_item_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["promotion_line_item_id"], name: "index_line_items_on_promotion_line_item_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.decimal "total_price", default: "0.0", null: false
    t.decimal "discounted_price", default: "0.0", null: false
    t.string "order_number", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["order_number"], name: "index_orders_on_order_number"
  end

  create_table "promotion_line_items", force: :cascade do |t|
    t.bigint "source_item_id", null: false
    t.bigint "dest_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dest_item_id"], name: "index_promotion_line_items_on_dest_item_id"
    t.index ["source_item_id"], name: "index_promotion_line_items_on_source_item_id"
  end

  add_foreign_key "line_items", "group_items"
  add_foreign_key "line_items", "items"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "promotion_line_items"
  add_foreign_key "orders", "customers"
  add_foreign_key "promotion_line_items", "items", column: "dest_item_id"
  add_foreign_key "promotion_line_items", "items", column: "source_item_id"
end
