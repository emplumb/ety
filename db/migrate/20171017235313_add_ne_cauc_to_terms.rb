class AddNeCaucToTerms < ActiveRecord::Migration[5.0]
  def change
    add_column :terms, :ne_cauc, :text
  end
end
