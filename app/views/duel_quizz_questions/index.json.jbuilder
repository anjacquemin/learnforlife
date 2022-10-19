if @quizz_end
  json.end render(partial: "end-duel-quizz-button", formats: :html, locals: {duel_answer: @duel_quizz})
else
  json.inserted_item render(partial: "question", formats: :html, locals: {current_duel_quizz_question: @current_duel_quizz_question})
end
