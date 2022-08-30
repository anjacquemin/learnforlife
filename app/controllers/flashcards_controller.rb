class FlashcardsController < ApplicationController
  def index
    policy_scope(Flashcard)
    @theme = Theme.find(params[:theme_id])
    @flashcards = current_user.flashcards.select {|flashcard| flashcard.question_answer.theme == @theme}
    @flashcards
  end

  def update
    data = JSON.parse(params["json"])

    flashcard = flashcard.find(data["flashcard_id"])
    auto_eval = flashcard.find(data["auto_eval"])

    # clasculer


    # if not toaday ok
    #if not put in the deck
  end
end
