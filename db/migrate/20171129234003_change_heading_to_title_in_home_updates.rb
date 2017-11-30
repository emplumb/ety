class ChangeHeadingToTitleInHomeUpdates < ActiveRecord::Migration[5.0]
  def change
  	rename_column :home_updates, :heading, :title
  end
end
