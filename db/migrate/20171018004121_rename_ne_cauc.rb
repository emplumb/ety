class RenameNeCauc < ActiveRecord::Migration[5.0]
  def change
    rename_column :terms, :ne_cauc, :ne_caucasian
  end
end
