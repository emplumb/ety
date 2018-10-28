class AddUniquenessConstraintToCitations < ActiveRecord::Migration[5.0]
  def change
  	add_index :citations, [:term_id, :source_id], unique: true
  end
end
