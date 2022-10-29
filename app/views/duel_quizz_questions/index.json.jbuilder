if @quizz_end
  json.end render(partial: "shared/show-quizz-score-modal", formats: :html, locals: {duel_quizz_id: @duel_quizz.id, player_id: current_user.id})
else
  json.inserted_item render(partial: "index_partial", formats: :html, locals: {current_duel_quizz_question: @current_duel_quizz_question})
end
