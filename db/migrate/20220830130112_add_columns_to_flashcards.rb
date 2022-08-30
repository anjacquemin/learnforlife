class AddColumnsToFlashcards < ActiveRecord::Migration[6.1]
  def change
    add_column :flashcards, :status, :string
    add_column :flashcards, :steps_index, :integer
  end
end
