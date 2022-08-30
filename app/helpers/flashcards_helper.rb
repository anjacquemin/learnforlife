module FlashcardsHelper
  def all_flashcards_to_learn
    current_user.flashcards.select {|flashcard|
    (flashcard.status == "learning" ||
    flashcard.status == "relearning") &&
    flashcard.day_of_next_repetition < DateTime.current}
  end

  def theme_flashcards_to_learn(theme)
    current_user.flashcards.select {|flashcard|
    flashcard.question_answer.theme == theme &&
    (flashcard.status == "learning" ||
    flashcard.status == "relearning") &&
    flashcard.day_of_next_repetition < DateTime.current}
  end

  def all_flashcards_to_revise
    current_user.flashcards.select {|flashcard|
    flashcard.status == "learned" &&
    flashcard.day_of_next_repetition < DateTime.current}
  end

  def theme_flashcards_to_revise(theme)
    current_user.flashcards.select {|flashcard|
    flashcard.theme == theme &&
    flashcard.status == "learned" &&
    flashcard.day_of_next_repetition < DateTime.current}
  end
end
