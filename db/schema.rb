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

ActiveRecord::Schema.define(version: 20171017235313) do

  create_table "static_pages", force: :cascade do |t|
    t.text     "about"
    t.text     "phonology"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", force: :cascade do |t|
    t.string   "prefix"
    t.string   "name"
    t.string   "gender"
    t.string   "p_s"
    t.string   "part_of_speech"
    t.text     "definition"
    t.text     "etymology1"
    t.text     "etymology2"
    t.text     "uses"
    t.text     "variants"
    t.text     "romance_cognates"
    t.text     "italic_cognates"
    t.text     "etruscan"
    t.text     "celtic_cognates"
    t.text     "germanic_cognates"
    t.text     "baltoslavic_cognates"
    t.text     "albanian_cognates"
    t.text     "hellenic_cognates"
    t.text     "armenian_cognates"
    t.text     "indoiranian_cognates"
    t.text     "semitic"
    t.text     "ie_cognates"
    t.text     "notes1"
    t.text     "notes2"
    t.text     "quote"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.text     "uralic"
    t.text     "ne_cauc"
    t.index ["slug"], name: "index_terms_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "username"
    t.string   "remember_digest"
  end

end
