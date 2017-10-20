class CreateHomeUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :home_updates do |t|
      t.text :heading
      t.text :body

      t.timestamps
    end
  end
end
