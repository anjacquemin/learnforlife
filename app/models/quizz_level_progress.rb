class QuizzLevelProgress < ApplicationRecord
  belongs_to :user
  belongs_to :quizz_level
  has_one :theme, through: :quizz_level
end
