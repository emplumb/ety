class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :prefix
      t.string :name
      t.string :gender
      t.string :p_s
      t.string :part_of_speech
      t.text :definition
      t.text :etymology1
      t.text :etymology2
      t.text :uses
      t.text :variants
      t.text :romance_cognates
      t.text :italic_cognates
      t.text :etruscan
      t.text :celtic_cognates
      t.text :germanic_cognates
      t.text :baltoslavic_cognates
      t.text :albanian_cognates
      t.text :hellenic_cognates
      t.text :armenian_cognates
      t.text :indoiranian_cognates
      t.text :semitic
      t.text :ie_cognates
      t.text :notes1
      t.text :notes2
      t.text :quote

      t.timestamps

    end
  end
end
