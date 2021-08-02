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

ActiveRecord::Schema.define(version: 2021_08_01_020349) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.string "district"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "addressable_type", null: false
    t.integer "addressable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "latitude"
    t.decimal "longitude"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "dispatch_logs", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "user_id", null: false
    t.string "authorized_person"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "item"
    t.index ["item"], name: "index_dispatch_logs_on_item", unique: true
    t.index ["item_id"], name: "index_dispatch_logs_on_item_id"
    t.index ["user_id"], name: "index_dispatch_logs_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "code"
    t.integer "supplier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.integer "product_entry_id", null: false
    t.integer "warehouse_id", null: false
    t.string "sku"
    t.integer "product_id", null: false
    t.index ["code"], name: "index_items_on_code", unique: true
    t.index ["product_entry_id"], name: "index_items_on_product_entry_id"
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["sku"], name: "index_items_on_sku"
    t.index ["supplier_id"], name: "index_items_on_supplier_id"
    t.index ["warehouse_id"], name: "index_items_on_warehouse_id"
  end

  create_table "product_entries", force: :cascade do |t|
    t.string "sku"
    t.string "invoice"
    t.integer "quantity"
    t.integer "supplier_id", null: false
    t.integer "warehouse_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "index_product_entries_on_product_id"
    t.index ["sku"], name: "index_product_entries_on_sku"
    t.index ["supplier_id"], name: "index_product_entries_on_supplier_id"
    t.index ["warehouse_id"], name: "index_product_entries_on_warehouse_id"
  end

  create_table "product_warehouses", force: :cascade do |t|
    t.integer "warehouse_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id", "warehouse_id"], name: "index_product_warehouses_on_product_id_and_warehouse_id", unique: true
    t.index ["product_id"], name: "index_product_warehouses_on_product_id"
    t.index ["warehouse_id"], name: "index_product_warehouses_on_warehouse_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "sku"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sku"], name: "index_products_on_sku", unique: true
  end

  create_table "reserve_logs", force: :cascade do |t|
    t.integer "item_id", null: false
    t.string "shipping_company"
    t.string "request_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sku"
    t.index ["item_id"], name: "index_reserve_logs_on_item_id"
  end

  create_table "return_entries", force: :cascade do |t|
    t.integer "request_number"
    t.string "item_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_code"], name: "index_return_entries_on_item_code"
    t.index ["request_number"], name: "index_return_entries_on_request_number"
  end

  create_table "return_logs", force: :cascade do |t|
    t.integer "return_entry_id", null: false
    t.text "justification"
    t.integer "decision", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
    t.index ["return_entry_id"], name: "index_return_logs_on_return_entry_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "cnpj"
    t.string "name"
    t.string "trade_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: true
    t.index ["cnpj"], name: "index_suppliers_on_cnpj", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.string "cpf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "registration_code"
    t.integer "warehouse_id"
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["warehouse_id"], name: "index_users_on_warehouse_id"
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_warehouses_on_code", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "dispatch_logs", "items"
  add_foreign_key "dispatch_logs", "users"
  add_foreign_key "items", "product_entries"
  add_foreign_key "items", "products"
  add_foreign_key "items", "suppliers"
  add_foreign_key "items", "warehouses"
  add_foreign_key "product_entries", "products"
  add_foreign_key "product_entries", "suppliers"
  add_foreign_key "product_entries", "warehouses"
  add_foreign_key "product_warehouses", "products"
  add_foreign_key "product_warehouses", "warehouses"
  add_foreign_key "reserve_logs", "items"
  add_foreign_key "return_entries", "items", column: "item_code", primary_key: "code"
  add_foreign_key "return_logs", "return_entries"
  add_foreign_key "users", "warehouses"
end
