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

ActiveRecord::Schema.define(version: 2022_08_08_194740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "theme_level_progresses", force: :cascade do |t|
    t.boolean "unlocked"
    t.bigint "user_id", null: false
    t.bigint "theme_level_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["theme_level_id"], name: "index_theme_level_progresses_on_theme_level_id"
    t.index ["user_id"], name: "index_theme_level_progresses_on_user_id"
  end

  create_table "theme_levels", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.text "objective"
    t.bigint "theme_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["theme_id"], name: "index_theme_levels_on_theme_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "hp", default: 50
    t.integer "xp", default: 0
    t.integer "gem", default: 0
    t.integer "gold", default: 0
    t.integer "level", default: 1
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "theme_level_progresses", "theme_levels"
  add_foreign_key "theme_level_progresses", "users"
  add_foreign_key "theme_levels", "themes"
end
