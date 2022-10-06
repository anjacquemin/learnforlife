class UserAnswersController < ApplicationController
  def create
    data = JSON.parse(params["json"])
    question_answer = QuestionAnswer.find(data["question_id"])

    p "user answer : #{data["user_answer"]}"

    if data["quizz_level"] == "Facile" || data["quizz_level"] == "Moyen"
      user_answer = data["user_answer"]

      answer_id = (user_answer == question_answer.answer) ? question_answer.id : 0
      is_good_answer = (user_answer == question_answer.answer)

      user_answer = UserAnswer.new(question_answer_id:  data["question_id"], answer_id: answer_id, quizz_answer_id: data["quizz_answer_id"], answer: user_answer)
      # for test : always OK
      # user_answer = UserAnswer.new(question_answer_id:  data["question_id"], answer_id: question_answer.id, quizz_answer_id: data["quizz_answer_id"], answer: question_answer.answer)
      authorize(user_answer)

    elsif data["quizz_level"] == "Difficile"
      user_answer = I18n.transliterate(data["user_answer"], :locale => :en).downcase.strip.gsub("-", " ")
      answer = I18n.transliterate(question_answer.answer,:locale => :en).downcase.strip.gsub("-", " ")

      p "####################"
      p "#######LEVENSHTEIN#############"
      p "user_answer: #{user_answer}"
      p "answer: #{answer}"
      p "distance: #{Levenshtein.distance(user_answer, answer)}"
      if Levenshtein.distance(user_answer, answer) <= 1
        answer_id = question_answer.id
        is_good_answer = true
      else
        answer_id = 0
        is_good_answer = false
      end
      user_answer = UserAnswer.new(question_answer_id:  data["question_id"], answer_id: answer_id, quizz_answer_id: data["quizz_answer_id"], answer: data["user_answer"])
      # for test : always OK
      # user_answer = UserAnswer.new(question_answer_id:  data["question_id"], answer_id: answer_id, quizz_answer_id: data["quizz_answer_id"], answer: user.answer)
      authorize(user_answer)
    end
    user_answer.save!
    respond_to do |format|
      data = {is_good_answer: is_good_answer, good_answer: question_answer.answer}
      format.json {render json: data}
    end
  end
end
