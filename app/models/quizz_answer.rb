class QuizzAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :quizz
  has_many :user_answers
end
