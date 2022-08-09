class CreateAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :achievements do |t|
      t.string :name
      t.text :description
      t.integer :xp_to_win

      t.timestamps
    end
  end
end
