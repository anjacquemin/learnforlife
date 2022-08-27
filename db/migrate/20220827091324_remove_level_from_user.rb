class RemoveLevelFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :level
  end
end
