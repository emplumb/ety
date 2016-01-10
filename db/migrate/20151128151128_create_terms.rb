class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :first
      t.string :name
      t.string :gender
      t.string :part_of_speech
      t.text :definition
      t.text :etymology1
      t.text :etymology2
      t.text :uses
      t.text :romance_cognates
      t.text :notes1
      t.text :notes2
      t.text :quote1
      t.text :quote2

      t.timestamps

    end
  end
end
