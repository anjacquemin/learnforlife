class AddColumnsToAchievement < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements, :achievement_type, :string
    add_column :achievements, :img_src, :string
    add_column :achievements, :count, :integer
  end
end
