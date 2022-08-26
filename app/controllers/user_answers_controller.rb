class UserAnswersController < ApplicationController
  def show
    # check if last answer has been received
  end

  def create
    # implement strong params
    data = JSON.parse(params["json"])
    p "---------------------------------"
    p "creation of user answer"
    # p "user_answer : #{user_answer}"
    p data["user_answer"]

    if data["quizz_level"] == "Facile" || data["quizz_level"] == "Moyen"
      user_answer = UserAnswer.new(question_answer_id:  data["question_id"], answer_id: data["user_answer_id"], quizz_answer_id: data["quizz_answer_id"], answer: data["user_answer"])


      authorize(user_answer)

      user_answer.save!
    elsif data["quizz_level"] == "Difficile"
      # set answer if if it is the good answer

      user_answer = I18n.transliterate(data["user_answer"], :locale => :en).downcase.strip

      question_answer = QuestionAnswer.find(data["question_id"])
      answer = I18n.transliterate(question_answer.answer,:locale => :en).downcase.strip

      if user_answer == answer
        answer_id = question_answer.id
        is_good_answer = true
      else
        answer_id = 0
        is_good_answer = false
      end

      user_answer = UserAnswer.new(question_answer_id:  data["question_id"], answer_id: answer_id, quizz_answer_id: data["quizz_answer_id"], answer: data["user_answer"])
      user_answer.save!

      respond_to do |format|
        data = {is_good_answer: is_good_answer}
        format.json {render :json => data}
      end
    end
  end
end
