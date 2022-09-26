class QuizzProgress < ApplicationRecord
  belongs_to :quizz
  has_one :theme, through: :quizz
  belongs_to :user

  validates :unlocked, inclusion: [true, false]

end
