class CreatePhonologyPages < ActiveRecord::Migration[5.0]
  def change
    create_table :phonology_pages do |t|
      t.text :body

      t.timestamps
    end
  end
end
