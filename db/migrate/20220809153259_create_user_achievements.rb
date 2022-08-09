class CreateUserAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :user_achievements do |t|
      t.references :achievement, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :unlocked

      t.timestamps
    end
  end
end
