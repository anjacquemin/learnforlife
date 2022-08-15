class QuizzAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :quizz_level
  has_many :user_answers
end
