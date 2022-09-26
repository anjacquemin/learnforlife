class Record < ApplicationRecord
  belongs_to :user
  belongs_to :quizz_level
  has_one :theme, through: :quizz_level
  has_one :quizz, through: :quizz_level
  has_one :quizz_answer
  has_many :question_answers, through: :quizz_level

  validates :completion, inclusion: { in: [0, 1,2,3] }
  validates :crown_or_sphere, inclusion: { in: %w(crown sphere) }
  validates :score_percentage, presence: true
  validates :seconds_duration, presence: true
  validates :milliseconds_duration, presence: true
  validates :dealt_with, presence: true
end
