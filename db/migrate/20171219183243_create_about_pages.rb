class CreateAboutPages < ActiveRecord::Migration[5.0]
  def change
    create_table :about_pages do |t|
      t.text :quote
      t.text :body

      t.timestamps
    end
  end
end
