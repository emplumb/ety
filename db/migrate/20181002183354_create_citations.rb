class CreateCitations < ActiveRecord::Migration[5.0]
  def change
    create_table :citations do |t|
      t.references :term, foreign_key: true
      t.references :source, foreign_key: true

      t.timestamps
    end
  end
end
