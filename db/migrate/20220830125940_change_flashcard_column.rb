class ChangeFlashcardColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :flashcards, :easyness_factor, :ease_factor
  end
end
