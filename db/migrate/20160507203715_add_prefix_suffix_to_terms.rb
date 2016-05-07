class AddPrefixSuffixToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :prefix_suffix, :string
  end
end
