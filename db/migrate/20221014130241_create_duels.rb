class CreateDuels < ActiveRecord::Migration[6.1]
  def change
    create_table :duels do |t|
      t.integer :player_1_hp
      t.integer :player_2_hp
      t.references :player_1, foreign_key: {to_table: :users}
      t.references :player_2, foreign_key: {to_table: :users}
      t.references :player_to_play, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
