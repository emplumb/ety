class CreateSources < ActiveRecord::Migration[5.0]
  def change
    create_table :sources do |t|
      t.string :author
      t.string :article
      t.string :editorial_in
      t.string :book
      t.string :journal
      t.string :printing
      t.string :year
      t.string :website

      t.timestamps
    end
  end
end
