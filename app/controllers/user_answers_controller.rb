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
    user_answer = UserAnswer.new(question_answer_id:  data["question_id"], answer_id: data["user_answer_id"], quizz_answer_id: data["quizz_answer_id"], answer: data["user_answer"])
    user_answer.save!

    
  end
end
