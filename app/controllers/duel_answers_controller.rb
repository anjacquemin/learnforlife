class DuelAnswersController < ApplicationController
  def create
    data = JSON.parse(params["json"])
    @duel_quizz_question = DuelQuizzQuestion.find(data["duel_quizz_question_id"].to_i)
    @difficulty = data["difficulty_choice"]

    p @difficulty

    @duel_answer = DuelAnswer.new(
      duel_quizz_question: @duel_quizz_question,
      user: current_user,
      answer: "",
      is_good_answer: "",
      difficulty: @difficulty
    )

    @quizz =  @duel_quizz_question.quizz

    if @difficulty == "easy"
      number_of_suggested_answer = 2
      @stars_count = 1
    elsif @difficulty == "medium"
      number_of_suggested_answer = 4
      @stars_count = 2
    else @difficulty == "hard"
      @stars_count = 3
    end
    #create set of answers
    if @difficulty != "hard"
      @suggested_answers = []
      @duel_quizz_question.quizz.question_answers.each{ |question_answer|
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
        @suggested_answers = suggested_answers_builder
      }
    end

    authorize @duel_answer

    if @duel_answer.save!
      respond_to do |format|
        format.json
      end
    else
      @duel_answer.valid?
      flash[:info] = @duel_answer.errors.messages.map{|k, v| "#{k} #{v.first} \n" }.join(" & ")
      redirect_to duel_quizz_questions_path(@duel_quizz_question_id)
    end
  end

  def update
    data = JSON.parse(params["json"])
    @duel_answer = DuelAnswer.find(data["duel_answer_id"])
    question_answer = @duel_answer.question_answer
    p "user answer : #{data["user_answer"]}"

    if @duel_answer.difficulty == "easy" || @duel_answer.difficulty == "medium"
      user_answer = data["user_answer"]
      answer_id = (user_answer == question_answer.answer) ? question_answer.id : 0
      is_good_answer = (user_answer == question_answer.answer)

    elsif @duel_answer.difficulty == "hard"
      user_answer = I18n.transliterate(data["user_answer"], :locale => :en).downcase.strip.gsub("-", " ")
      answer = I18n.transliterate(question_answer.answer,:locale => :en).downcase.strip.gsub("-", " ")
      is_good_answer = (Levenshtein.distance(user_answer, answer) <= 1)
    end

    authorize(@duel_answer)

    @duel_answer.answer = user_answer
    @duel_answer.is_good_answer = is_good_answer
    @duel_answer.save!


    respond_to do |format|
      data = {is_good_answer: is_good_answer, good_answer: question_answer.answer}
      format.json {render json: data}
    end
  end
end
