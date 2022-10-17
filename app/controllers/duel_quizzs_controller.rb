class DuelQuizzsController < ApplicationController
  def create
    @duel = Duel.find(params[:duel_id].to_i)
    @theme = Theme.find(params[:theme_id])
    @duel_quizz = DuelQuizz.new(duel: @duel, theme: @theme)

    question_answers_building = @theme.question_answers.joins(quizzs: :category).where.not(quizzs: {name: "MASTER"}).pluck('question_answers.id, categories.id').sample(10)

    question_answers_building.each do |question_answer_building|
      duel_quizz_question = DuelQuizzQuestion.new(duel_quizz: @duel_quizz, question_answer:  QuestionAnswer.find(question_answer_building[0]), category: Category.find(question_answer_building[1]))
      duel_quizz_question.save!
    end

    authorize @duel_quizz

    if @duel_quizz.save!
      redirect_to duel_duel_quizz_duel_quizz_questions_url(@duel,@duel_quizz)
    else
      @duel_quizz.valid?
      flash[:info] = @duel_quizz.errors.messages.map{|k, v| "#{k} #{v.first} \n" }.join(" & ")
      redirect_to duel_path(@duel)
    end
  end
end
