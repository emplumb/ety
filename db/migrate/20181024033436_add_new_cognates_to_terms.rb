class AddNewCognatesToTerms < ActiveRecord::Migration[5.0]
  def change
  	drop_table :terms, force: :cascade

    create_table :terms do |t|
      t.string :prefix
      t.string :slug
      t.string :name
      t.string :gender
      t.string :prefix_suffix
      t.string :part_of_speech
      t.text :definition
      t.text :etymology1
      t.text :etymology2
      t.text :uses
      t.text :variants
      t.text :indo_european_cognates
      t.text :romance_cognates
      t.text :italic_cognates
      t.text :celtic_cognates
      t.text :germanic_cognates
      t.text :albanian_cognates
      t.text :balto_slavic_cognates
      t.text :hellenic_cognates
      t.text :thracian_cognates
      t.text :phrygian_cognates
      t.text :messapian_cognates
      t.text :armenian_cognates
      t.text :indo_iranian_cognates
      t.text :tocharian_cognates
      t.text :anatolian_cognates
      t.text :basque_cognates
      t.text :tyrsenian_cognates
      t.text :uralic_cognates
      t.text :sami_cognates
      t.text :finnic_cognates
      t.text :mordvinic_cognates
      t.text :mari_cognates
      t.text :mansi_cognates
      t.text :khanty_cognates
      t.text :northeast_caucasian_cognates
      t.text :nakh_cognates
      t.text :lezgic_cognates
      t.text :dargwa_cognates
      t.text :lak_cognates
      t.text :lezghian_cognates
      t.text :afro_asiatic_cognates
      t.text :egyptian_cognates
      t.text :semitic_cognates
      t.text :notes1
      t.text :notes2

      t.timestamps
      t.index ["slug"], name: "index_terms_on_slug", unique: true, using: :btree
    end
  end
end
