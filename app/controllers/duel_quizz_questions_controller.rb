class DuelQuizzQuestionsController < ApplicationController
  def index
    @duel_quizz = DuelQuizz.find(params[:duel_quizz_id])
    @duel_quizz_questions = policy_scope(@duel_quizz.duel_quizz_questions)
    @current_duel_quizz_question = @duel_quizz_questions.find do |duel_quizz_question|
      if duel_quizz_question.duel_answers.any?
        duel_quizz_question unless duel_quizz_question.duel_answers.find(user: current_user)
      end
      duel_quizz_question
    end
  end
end
