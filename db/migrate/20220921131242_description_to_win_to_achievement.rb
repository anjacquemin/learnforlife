class DescriptionToWinToAchievement < ActiveRecord::Migration[6.1]
  def change
    remove_column :achievements, :description
  end
end
