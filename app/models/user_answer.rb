class UserAnswer < ApplicationRecord
  belongs_to :quizz_answer
  belongs_to :question_answer
end
