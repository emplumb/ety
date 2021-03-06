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

ActiveRecord::Schema.define(version: 20181117002432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "about_pages", force: :cascade do |t|
    t.text     "quote"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "citations", force: :cascade do |t|
    t.integer  "term_id"
    t.integer  "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id"], name: "index_citations_on_source_id", using: :btree
    t.index ["term_id", "source_id"], name: "index_citations_on_term_id_and_source_id", unique: true, using: :btree
    t.index ["term_id"], name: "index_citations_on_term_id", using: :btree
  end

  create_table "contact_requests", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "home_updates", force: :cascade do |t|
    t.text     "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phonology_pages", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sources", force: :cascade do |t|
    t.string   "author"
    t.string   "article"
    t.string   "other"
    t.string   "book"
    t.string   "journal"
    t.string   "printing"
    t.string   "year"
    t.string   "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "static_pages", force: :cascade do |t|
    t.text     "about"
    t.text     "phonology"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", force: :cascade do |t|
    t.string   "prefix"
    t.string   "slug"
    t.string   "name"
    t.string   "gender"
    t.string   "prefix_suffix"
    t.string   "part_of_speech"
    t.text     "definition"
    t.text     "etymology1"
    t.text     "etymology2"
    t.text     "uses"
    t.text     "variants"
    t.text     "indo_european_cognates"
    t.text     "romance_cognates"
    t.text     "italic_cognates"
    t.text     "celtic_cognates"
    t.text     "germanic_cognates"
    t.text     "albanian_cognates"
    t.text     "balto_slavic_cognates"
    t.text     "hellenic_cognates"
    t.text     "thracian_cognates"
    t.text     "phrygian_cognates"
    t.text     "messapian_cognates"
    t.text     "armenian_cognates"
    t.text     "indo_iranian_cognates"
    t.text     "tocharian_cognates"
    t.text     "anatolian_cognates"
    t.text     "basque_cognates"
    t.text     "tyrsenian_cognates"
    t.text     "uralic_cognates"
    t.text     "sami_cognates"
    t.text     "finnic_cognates"
    t.text     "mordvinic_cognates"
    t.text     "mari_cognates"
    t.text     "mansi_cognates"
    t.text     "khanty_cognates"
    t.text     "northeast_caucasian_cognates"
    t.text     "nakh_cognates"
    t.text     "lezgic_cognates"
    t.text     "dargwa_cognates"
    t.text     "lak_cognates"
    t.text     "lezghian_cognates"
    t.text     "afro_asiatic_cognates"
    t.text     "egyptian_cognates"
    t.text     "semitic_cognates"
    t.text     "notes1"
    t.text     "notes2"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["slug"], name: "index_terms_on_slug", unique: true, using: :btree
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

  add_foreign_key "citations", "sources"
end
