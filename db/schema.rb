# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_04_115305) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_events", force: :cascade do |t|
    t.string "name"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.text "address"
    t.text "description"
    t.string "link"
    t.bigint "church_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "location"
    t.text "image_data"
    t.index ["church_id"], name: "index_admin_events_on_church_id"
  end

  create_table "admin_live_streams", force: :cascade do |t|
    t.string "name"
    t.string "playback_policy"
    t.string "mux_stream_id"
    t.string "mux_stream_key"
    t.bigint "church_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "playback_id"
    t.string "embed_code"
    t.index ["church_id"], name: "index_admin_live_streams_on_church_id"
    t.index ["embed_code"], name: "index_admin_live_streams_on_embed_code"
  end

  create_table "admin_media_images", force: :cascade do |t|
    t.string "caption"
    t.bigint "church_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "image_data"
    t.index ["church_id"], name: "index_admin_media_images_on_church_id"
  end

  create_table "admin_media_sermons", force: :cascade do |t|
    t.string "title"
    t.string "speaker"
    t.string "scripture"
    t.bigint "church_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "video_data"
    t.boolean "published", default: false
    t.text "hls_url"
    t.text "hls_thumbnail_url"
    t.text "thumbnail_data"
    t.index ["church_id"], name: "index_admin_media_sermons_on_church_id"
  end

  create_table "admin_members", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.bigint "church_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text "profile_picture_data"
    t.index ["church_id"], name: "index_admin_members_on_church_id"
    t.index ["email"], name: "index_admin_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_members_on_reset_password_token", unique: true
  end

  create_table "admin_news", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "church_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "image_data"
    t.index ["church_id"], name: "index_admin_news_on_church_id"
  end

  create_table "admin_simulcast_targets", force: :cascade do |t|
    t.string "stream_key"
    t.string "url"
    t.bigint "admin_live_stream_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "platform"
    t.string "mux_simulcast_id"
    t.index ["admin_live_stream_id"], name: "index_admin_simulcast_targets_on_admin_live_stream_id"
  end

  create_table "admin_websites", force: :cascade do |t|
    t.string "primary_color"
    t.string "heading_font"
    t.string "body_font"
    t.string "youtube_live"
    t.bigint "church_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "hero_image_data"
    t.index ["church_id"], name: "index_admin_websites_on_church_id"
  end

  create_table "churches", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "phone_number"
    t.string "fb"
    t.string "youtube"
    t.string "instagram"
    t.text "give_link"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "logo_data"
    t.index ["user_id"], name: "index_churches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 1
    t.string "fname"
    t.string "lname"
    t.string "invite_token"
    t.datetime "invite_sent_at"
    t.boolean "invitation_completed", default: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "time_zone"
    t.string "subdomain"
    t.text "profile_picture_data"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email", "subdomain"], name: "index_users_on_email_and_subdomain", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_live_streams", "churches"
  add_foreign_key "admin_media_images", "churches"
  add_foreign_key "admin_media_sermons", "churches"
  add_foreign_key "admin_members", "churches"
  add_foreign_key "admin_simulcast_targets", "admin_live_streams"
  add_foreign_key "admin_websites", "churches"
  add_foreign_key "churches", "users"
end
