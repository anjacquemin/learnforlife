class AddCategoryToAchievement < ActiveRecord::Migration[6.1]
  def change
    add_reference :achievements, :category, foreign_key: true
    add_reference :achievements, :theme, foreign_key: true
  end
end
