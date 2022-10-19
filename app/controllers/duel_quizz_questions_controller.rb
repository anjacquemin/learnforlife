class DuelQuizzQuestionsController < ApplicationController
  def index
    @duel_quizz = DuelQuizz.find(params[:duel_quizz_id])
    @duel_quizz_questions = policy_scope(@duel_quizz.duel_quizz_questions)
    @duel = @duel_quizz.duel
    # Return the first quizz question with not answered by current_user
    @current_duel_quizz_question = @duel_quizz_questions.find do |duel_quizz_question|
      if duel_quizz_question.duel_answers.any?
        duel_quizz_question unless duel_quizz_question.duel_answers.find_by(user: current_user)
      else
        duel_quizz_question
      end
    end

    if (@quizz_end = check_end_duel_quizz(@duel_quizz))
      score_compute(@duel_quizz)
    end


    respond_to do |format|
      format.html
      format.json
    end
  end
end


def check_end_duel_quizz(duel_quizz)
  p """"""""""""""""""""""""
  p duel_quizz.duel_answers.count { |duel_answer| duel_answer.user == current_user }
  p "//////////////////////////////"
  duel_quizz.duel_answers.count { |duel_answer| duel_answer.user == current_user } > 2
end

def score_compute(duel_quizz)
  duel_quizz.duel_answers.where(user: current_user)
  score = 2
  if duel_quizz.duel.player_1 == current_user
    duel_quizz.update(score_player_1: score)
  else
    duel_quizz.update(score_player_2: score)
  end
end
