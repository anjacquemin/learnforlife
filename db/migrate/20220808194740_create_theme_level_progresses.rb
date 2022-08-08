class CreateThemeLevelProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :theme_level_progresses do |t|
      t.boolean :unlocked
      t.references :user, null: false, foreign_key: true
      t.references :theme_level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
