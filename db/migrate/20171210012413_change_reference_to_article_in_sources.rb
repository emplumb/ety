class ChangeReferenceToArticleInSources < ActiveRecord::Migration[5.0]
  def change
  	rename_column :sources, :reference, :article
  end
end
