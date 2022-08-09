class CreateSubthemeProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :subtheme_progresses do |t|
      t.references :subtheme, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :unlocked

      t.timestamps
    end
  end
end
