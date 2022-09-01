class RemoveQuizzFromQuestionAnswer < ActiveRecord::Migration[6.1]
  def change
    remove_reference :question_answers, :quizz, foreign_key: true, index: false
  end
end
