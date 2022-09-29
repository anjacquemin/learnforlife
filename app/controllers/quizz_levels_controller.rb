class QuizzLevelsController < ApplicationController
  def show
    @quizz_level = QuizzLevel.find(params[:id])
    authorize(@quizz_level)
    @quizz = @quizz_level.quizz
    @quizz_answer = QuizzAnswer.new(user: current_user, quizz_level: @quizz_level)
    @quizz_answer.save!
    @user_answer = UserAnswer.new()
    if @quizz_level.name == "Facile"
      number_of_suggested_answer = 2
      @stars_count = 1
    elsif @quizz_level.name == "Moyen"
      number_of_suggested_answer = 4
      @stars_count = 2
    else @quizz_level.name == "Difficile"
      @stars_count = 3
    end
    #create set of answers
    if @quizz_level.name != "Difficile"
      @suggested_answers = {}
      @quizz.question_answers.each{ |question_answer|
        if question_answer.suggested_answers.count < 3
          all_possible_answers = @quizz.question_answers.map(&:answer)
        else
          all_possible_answers = question_answer.suggested_answers.map(&:answer)
        end
        suggested_answers_builder = []
        suggested_answers_builder << question_answer.answer
        all_possible_answers.delete(question_answer.answer)
        #choose a random answer among the quizz
        wrong_answers = all_possible_answers.sample((number_of_suggested_answer - 1))
        suggested_answers_builder.concat(wrong_answers).shuffle!
        @suggested_answers[question_answer.id.to_s.to_sym] = suggested_answers_builder
      }
    end
  end
end
