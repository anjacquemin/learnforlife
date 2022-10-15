class CreateDuelQuizzs < ActiveRecord::Migration[6.1]
  def change
    create_table :duel_quizzs do |t|
      t.references :theme, null: false, foreign_key: true
      t.integer :score_player_1
      t.integer :score_player_2
      t.references :duel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
