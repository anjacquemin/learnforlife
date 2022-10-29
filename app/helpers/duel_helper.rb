module DuelHelper
  def anwser_score_compute(answer)
    return 0 unless answer.is_good_answer

    score = 0
    difficulty_points = {
      Facile: 1,
      Moyen: 3,
      Difficile: 5
    }
    difficulty_points[answer.difficulty.to_sym] if answer.is_good_answer
  end

  def bonus?(duel_quizz, player)
    duel_quizz.duel_answers.where(user: player).all? { |duel_quizz| duel_quizz.is_good_answer}
  end
end
