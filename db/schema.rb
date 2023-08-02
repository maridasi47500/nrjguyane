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

ActiveRecord::Schema[7.0].define(version: 2023_08_02_224521) do
  create_table "animateurs", force: :cascade do |t|
    t.string "title"
    t.string "type"
    t.string "image"
    t.text "description"
    t.boolean "link"
    t.text "subtitle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "job"
  end

  create_table "emissionhasanimateurs", force: :cascade do |t|
    t.integer "emission_id"
    t.integer "animateur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emissions", force: :cascade do |t|
    t.string "title"
    t.string "type"
    t.string "image"
    t.string "description"
    t.boolean "link"
    t.time "duree_emission"
    t.time "heure_emission"
    t.string "subtitle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hasweekdays", force: :cascade do |t|
    t.integer "emission_id"
    t.integer "weekday_id"
  end

  create_table "newsarticles", force: :cascade do |t|
    t.string "type"
    t.string "title"
    t.text "content"
    t.string "image"
    t.text "comphoto"
    t.string "subtitle"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "filename"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlistrecordings", force: :cascade do |t|
    t.integer "recording_id"
    t.integer "playlist_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.integer "current_id"
    t.datetime "heure_playlist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlistsongs", force: :cascade do |t|
    t.integer "song_id"
    t.string "playlist_id"
    t.datetime "heure_chanson"
  end

  create_table "posthavephotos", force: :cascade do |t|
    t.integer "photo_id"
    t.string "newsarticle_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "type"
    t.string "image"
    t.string "description"
    t.boolean "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subtitle"
  end

  create_table "recordings", force: :cascade do |t|
    t.string "title"
    t.string "artist"
    t.string "filename"
    t.float "duree"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.string "artist"
    t.string "filename"
    t.float "duree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videoplaylists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "myid"
    t.integer "videoplaylist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vidhasplaylists", force: :cascade do |t|
    t.integer "video"
    t.integer "videoplaylist_id"
  end

  create_table "weekdays", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
