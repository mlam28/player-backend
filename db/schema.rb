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

ActiveRecord::Schema.define(version: 2019_10_03_004927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "back_logs", force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "user_id"
    t.text "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.boolean "liked"
    t.integer "user_id"
    t.integer "song_playlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "song_playlists", force: :cascade do |t|
    t.string "song_spotify_id"
    t.integer "playlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "artist"
    t.string "uri"
    t.string "time"
    t.string "artist_uri"
  end

  create_table "user_playlists", force: :cascade do |t|
    t.string "playlist_spotify_id"
    t.integer "playlist_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "display_name"
    t.string "spotify_id"
    t.string "spotify_uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.text "spotify_info"
    t.string "image"
  end

end
