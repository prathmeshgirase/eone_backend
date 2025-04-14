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

ActiveRecord::Schema[7.1].define(version: 2025_04_14_165335) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assignment_submissions", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.bigint "user_id", null: false
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "marks"
    t.string "grade"
    t.index ["assignment_id"], name: "index_assignment_submissions_on_assignment_id"
    t.index ["user_id"], name: "index_assignment_submissions_on_user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "due_date"
    t.string "file"
    t.bigint "subject_id", null: false
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_assignments_on_subject_id"
    t.index ["teacher_id"], name: "index_assignments_on_teacher_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "teacher_id"
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "batch"
    t.string "year"
    t.index ["teacher_id"], name: "index_classrooms_on_teacher_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "assignment_id"
    t.bigint "teacher_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message"
    t.datetime "read_at"
    t.index ["assignment_id"], name: "index_notifications_on_assignment_id"
    t.index ["teacher_id"], name: "index_notifications_on_teacher_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.string "days_list", default: [], array: true
    t.string "start_time"
    t.string "end_time"
    t.bigint "teacher_id"
    t.bigint "classroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_subjects_on_classroom_id"
    t.index ["teacher_id"], name: "index_subjects_on_teacher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "mobile_number"
    t.integer "status"
    t.date "date_of_birth"
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "classroom_id"
    t.index ["classroom_id"], name: "index_users_on_classroom_id"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assignment_submissions", "assignments"
  add_foreign_key "assignment_submissions", "users"
  add_foreign_key "assignments", "subjects"
  add_foreign_key "assignments", "users", column: "teacher_id"
  add_foreign_key "classrooms", "users", column: "teacher_id"
  add_foreign_key "notifications", "assignments"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "teacher_id"
  add_foreign_key "subjects", "classrooms"
  add_foreign_key "subjects", "users", column: "teacher_id"
  add_foreign_key "users", "classrooms"
  add_foreign_key "users", "roles"
end
