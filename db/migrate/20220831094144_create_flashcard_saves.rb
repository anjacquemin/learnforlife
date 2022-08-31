class CreateFlashcardSaves < ActiveRecord::Migration[6.1]
  def change
    create_table :flashcard_saves do |t|
      t.integer :interval
      t.float :ease_factor
      t.integer :repetition
      t.integer :steps_index
      t.datetime :day_of_repetition
      t.string :auto_eval
      t.string :status
      t.boolean :dealt_with, default: false
      t.references :flashcard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
