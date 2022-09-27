class AddHistoryOnlyToThemes < ActiveRecord::Migration[6.1]
  def change
    add_column :themes, :adventure_only, :boolean
  end
end
