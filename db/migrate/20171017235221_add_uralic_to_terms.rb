class AddUralicToTerms < ActiveRecord::Migration[5.0]
  def change
    add_column :terms, :uralic, :text
  end
end
