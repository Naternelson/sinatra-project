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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_07_041941) do

  create_table "batchs", force: :cascade do |t|
    t.string "primary"
    t.string "secondary"
    t.date "mfg"
    t.date "exp"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_codes", force: :cascade do |t|
    t.string "code"
    t.integer "item_id"
    t.integer "item_requirement_id"
  end

  create_table "item_requirements", force: :cascade do |t|
    t.string "name"
    t.integer "length"
    t.string "description"
    t.boolean "unique"
    t.boolean "length_required"
    t.integer "product_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "order_num"
    t.integer "amount"
    t.datetime "received_on"
    t.datetime "due_by"
    t.integer "status"
    t.integer "product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "sku"
    t.string "description"
    t.string "color"
    t.string "company"
    t.integer "user_id"
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "password_digest"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
  end

end
