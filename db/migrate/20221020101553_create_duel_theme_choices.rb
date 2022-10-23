class CreateDuelThemeChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :duel_theme_choices do |t|
      t.references :duel, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true

      t.timestamps
    end
  end
end
