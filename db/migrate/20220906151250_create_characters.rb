class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string :body
      t.string :head
      t.string :hair
      t.boolean :first_set
      t.string :weapon
      t.string :background
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
