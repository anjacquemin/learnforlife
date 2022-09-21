class AddUnlockedConditionsToAchievement < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements, :unlocked_conditions, :text
  end
end
