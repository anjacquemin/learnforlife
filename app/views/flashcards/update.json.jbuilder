if @minutes == 1
  json.show_again true
  json.inserted_item render(partial: "flashcards/unique_flashcard", formats: :html, locals: {flashcard: @flashcard, index: @number_of_card_to_display})
end
