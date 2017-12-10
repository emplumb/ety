class AddAdditionalColumnsToSources < ActiveRecord::Migration[5.0]
  def change
  	add_column :sources, :editorial_in, :string
  	add_column :sources, :book, :string
  	add_column :sources, :journal, :string
  	add_column :sources, :printing, :string
  	add_column :sources, :year, :string
  	add_column :sources, :website, :string
  end
end
