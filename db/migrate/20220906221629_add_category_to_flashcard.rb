class AddCategoryToFlashcard < ActiveRecord::Migration[6.1]
  def change
    add_reference :flashcards, :category, foreign_key: true
  end
end
