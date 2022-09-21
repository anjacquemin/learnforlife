class AddAchievementCategoryToAchievement < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements, :achievement_category, :text
  end
end
