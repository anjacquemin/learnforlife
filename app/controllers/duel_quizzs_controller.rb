class DuelQuizzsController < ApplicationController
  def create
    data = JSON.parse(params["json"])
    @duel = Duel.find(params[:duel_id].to_i)
    @theme = Theme.find(data["theme_id"].to_i)
    @duel_quizz = DuelQuizz.new(duel: @duel, theme: @theme)

    question_answers_building = @theme.question_answers.joins(quizzs: :category).where.not(quizzs: {name: "MASTER"}).pluck('question_answers.id, categories.id, quizzs.id').sample(10)

    question_answers_building.each do |question_answer_building|
      duel_quizz_question = DuelQuizzQuestion.new(duel_quizz: @duel_quizz, question_answer:  QuestionAnswer.find(question_answer_building[0]), category: Category.find(question_answer_building[1]), quizz: Quizz.find(question_answer_building[2]))
      duel_quizz_question.save!
    end

    authorize @duel_quizz

    if @duel_quizz.save!
      DuelChannel.broadcast_to(@duel, type: "quizz_begin", duel_id: @duel.id, duel_quizz_id: @duel_quizz.id )
      respond_to do |format|
        format.json {render json: {duel_quizz_created: "true"}}
      end
    else
      @duel_quizz.valid?
      flash[:info] = @duel_quizz.errors.messages.map{|k, v| "#{k} #{v.first} \n" }.join(" & ")
      redirect_to duel_path(@duel)
    end
  end
end
