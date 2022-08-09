class CreateFlashcards < ActiveRecord::Migration[6.1]
  def change
    create_table :flashcards do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :unlocked
      t.text :trick
      t.boolean :editable
      t.float :easyness_factor
      t.integer :repetition
      t.integer :interval
      t.datetime :day_of_last_repetition
      t.datetime :day_of_next_repetition
      t.integer :mistake_count
      t.references :question_answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
