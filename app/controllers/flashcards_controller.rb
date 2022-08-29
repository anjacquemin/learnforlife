class FlashcardsController < ApplicationController
  def index
    policy_scope(Flashcard)
    @theme = Theme.find(params[:theme_id])
    @flashcards = current_user.flashcards.select {|flashcard| flashcard.question_answer.theme == @theme}
    @flashcards
  end
end
