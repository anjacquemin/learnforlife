class CreateSubthemes < ActiveRecord::Migration[6.1]
  def change
    create_table :subthemes do |t|
      t.references :theme_level, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
