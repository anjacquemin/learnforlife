class CreateUserCharacterItems < ActiveRecord::Migration[6.1]
  def change
    create_table :user_character_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :character_item, null: false, foreign_key: true
      t.boolean :unlocked

      t.timestamps
    end
  end
end
