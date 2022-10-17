class DuelQuizzQuestionsController < ApplicationController
  def index
    @duel_quizz = DuelQuizz.find(params[:duel_quizz_id])
    @duel_quizz_questions = policy_scope(@duel_quizz.duel_quizz_questions)
  end
end
