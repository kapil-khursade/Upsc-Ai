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

ActiveRecord::Schema[7.1].define(version: 2023_12_20_173049) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "auth_token"
    t.integer "role"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "answer_errors", force: :cascade do |t|
    t.bigint "question_id"
    t.integer "status"
    t.string "message"
    t.integer "try_number"
    t.string "querry_string"
    t.datetime "error_date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answer_errors_on_question_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.bigint "question_id"
    t.bigint "paper_id"
    t.string "answer"
    t.integer "usage_token"
    t.integer "charged_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_answers_on_admin_user_id"
    t.index ["paper_id"], name: "index_answers_on_paper_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "keyword"
    t.bigint "admin_user_id"
    t.bigint "question_id"
    t.bigint "paper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_keywords_on_admin_user_id"
    t.index ["paper_id"], name: "index_keywords_on_paper_id"
    t.index ["question_id"], name: "index_keywords_on_question_id"
  end

  create_table "papers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_details", force: :cascade do |t|
    t.string "order_id"
    t.string "payment_id"
    t.string "signature"
    t.date "date"
    t.float "amount"
    t.integer "tokens"
    t.integer "status", default: 0
    t.bigint "admin_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_payment_details_on_admin_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question", limit: 200
    t.bigint "admin_user_id"
    t.bigint "paper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "comma_separated_keywords"
    t.integer "answer_generation_status"
    t.index ["admin_user_id"], name: "index_questions_on_admin_user_id"
    t.index ["paper_id"], name: "index_questions_on_paper_id"
  end

  create_table "user_plans", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.integer "balanced_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_user_plans_on_admin_user_id"
  end

  add_foreign_key "answer_errors", "questions"
  add_foreign_key "answers", "admin_users"
  add_foreign_key "answers", "papers"
  add_foreign_key "answers", "questions"
  add_foreign_key "keywords", "admin_users"
  add_foreign_key "keywords", "papers"
  add_foreign_key "keywords", "questions"
  add_foreign_key "payment_details", "admin_users"
  add_foreign_key "questions", "admin_users"
  add_foreign_key "questions", "papers"
  add_foreign_key "user_plans", "admin_users"
end
