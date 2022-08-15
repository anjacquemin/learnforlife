class AddColumnAnswerIdtoUserAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :user_answers, :answer_id, :integer
  end
end
