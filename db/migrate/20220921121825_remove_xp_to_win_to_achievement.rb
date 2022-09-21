class RemoveXpToWinToAchievement < ActiveRecord::Migration[6.1]
  def change
    remove_column :achievements, :xp_to_win
  end
end
