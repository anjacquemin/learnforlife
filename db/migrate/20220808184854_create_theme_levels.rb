class CreateThemeLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :theme_levels do |t|
      t.string :name
      t.integer :level
      t.text :objective
      t.references :theme, null: false, foreign_key: true

      t.timestamps
    end
  end
end
