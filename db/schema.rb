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

ActiveRecord::Schema.define(version: 2022_08_26_101732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "xp_to_win"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
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
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "best_records", force: :cascade do |t|
    t.bigint "quizz_level_id", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quizz_level_id"], name: "index_best_records_on_quizz_level_id"
    t.index ["record_id"], name: "index_best_records_on_record_id"
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "subtheme_id", null: false
    t.string "name"
    t.text "objective"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subtheme_id"], name: "index_categories_on_subtheme_id"
  end

  create_table "category_progresses", force: :cascade do |t|
    t.boolean "unlocked"
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_progresses_on_category_id"
    t.index ["user_id"], name: "index_category_progresses_on_user_id"
  end

  create_table "flashcards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "unlocked"
    t.text "trick"
    t.boolean "editable"
    t.float "easyness_factor"
    t.integer "repetition"
    t.integer "interval"
    t.datetime "day_of_last_repetition"
    t.datetime "day_of_next_repetition"
    t.integer "mistake_count"
    t.bigint "question_answer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_answer_id"], name: "index_flashcards_on_question_answer_id"
    t.index ["user_id"], name: "index_flashcards_on_user_id"
  end

  create_table "question_answers", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.bigint "quizz_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quizz_id"], name: "index_question_answers_on_quizz_id"
  end

  create_table "quizz_answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quizz_level_id"
    t.index ["quizz_level_id"], name: "index_quizz_answers_on_quizz_level_id"
    t.index ["user_id"], name: "index_quizz_answers_on_user_id"
  end

  create_table "quizz_level_progresses", force: :cascade do |t|
    t.boolean "unlocked"
    t.bigint "user_id", null: false
    t.bigint "quizz_level_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quizz_level_id"], name: "index_quizz_level_progresses_on_quizz_level_id"
    t.index ["user_id"], name: "index_quizz_level_progresses_on_user_id"
  end

  create_table "quizz_levels", force: :cascade do |t|
    t.bigint "quizz_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quizz_id"], name: "index_quizz_levels_on_quizz_id"
  end

  create_table "quizz_progresses", force: :cascade do |t|
    t.bigint "quizz_id", null: false
    t.bigint "user_id", null: false
    t.boolean "unlocked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quizz_id"], name: "index_quizz_progresses_on_quizz_id"
    t.index ["user_id"], name: "index_quizz_progresses_on_user_id"
  end

  create_table "quizzs", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name"
    t.integer "ordering"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_quizzs_on_category_id"
  end

  create_table "records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "quizz_level_id", null: false
    t.integer "completion"
    t.string "crown_or_sphere"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "score_percentage"
    t.integer "seconds_duration"
    t.integer "milliseconds_duration"
    t.bigint "quizz_answer_id"
    t.boolean "dealt_with", default: false
    t.index ["quizz_answer_id"], name: "index_records_on_quizz_answer_id"
    t.index ["quizz_level_id"], name: "index_records_on_quizz_level_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "subtheme_progresses", force: :cascade do |t|
    t.bigint "subtheme_id", null: false
    t.bigint "user_id", null: false
    t.boolean "unlocked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subtheme_id"], name: "index_subtheme_progresses_on_subtheme_id"
    t.index ["user_id"], name: "index_subtheme_progresses_on_user_id"
  end

  create_table "subthemes", force: :cascade do |t|
    t.bigint "theme_level_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["theme_level_id"], name: "index_subthemes_on_theme_level_id"
  end

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

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "achievement_id", null: false
    t.bigint "user_id", null: false
    t.boolean "unlocked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.string "answer"
    t.bigint "quizz_answer_id", null: false
    t.bigint "question_answer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "answer_id"
    t.index ["question_answer_id"], name: "index_user_answers_on_question_answer_id"
    t.index ["quizz_answer_id"], name: "index_user_answers_on_quizz_answer_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "best_records", "quizz_levels"
  add_foreign_key "best_records", "records"
  add_foreign_key "categories", "subthemes"
  add_foreign_key "category_progresses", "categories"
  add_foreign_key "category_progresses", "users"
  add_foreign_key "flashcards", "question_answers"
  add_foreign_key "flashcards", "users"
  add_foreign_key "question_answers", "quizzs"
  add_foreign_key "quizz_answers", "quizz_levels"
  add_foreign_key "quizz_answers", "users"
  add_foreign_key "quizz_level_progresses", "quizz_levels"
  add_foreign_key "quizz_level_progresses", "users"
  add_foreign_key "quizz_levels", "quizzs"
  add_foreign_key "quizz_progresses", "quizzs"
  add_foreign_key "quizz_progresses", "users"
  add_foreign_key "quizzs", "categories"
  add_foreign_key "records", "quizz_answers"
  add_foreign_key "records", "quizz_levels"
  add_foreign_key "records", "users"
  add_foreign_key "subtheme_progresses", "subthemes"
  add_foreign_key "subtheme_progresses", "users"
  add_foreign_key "subthemes", "theme_levels"
  add_foreign_key "theme_level_progresses", "theme_levels"
  add_foreign_key "theme_level_progresses", "users"
  add_foreign_key "theme_levels", "themes"
  add_foreign_key "user_achievements", "achievements"
  add_foreign_key "user_achievements", "users"
  add_foreign_key "user_answers", "question_answers"
  add_foreign_key "user_answers", "quizz_answers"
end
