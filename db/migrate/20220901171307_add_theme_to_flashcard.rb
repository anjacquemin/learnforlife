class AddThemeToFlashcard < ActiveRecord::Migration[6.1]
  def change
    add_reference :flashcards, :theme, null: false, foreign_key: true
  end
end
