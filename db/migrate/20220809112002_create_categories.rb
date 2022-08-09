class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.references :subtheme, null: false, foreign_key: true
      t.string :name
      t.text :objective

      t.timestamps
    end
  end
end
