class Quizz < ApplicationRecord
  belongs_to :category
  has_many :quizz_progresses
  has_many :quizz_levels
  has_many :quizz_answers
  has_many :quizz_question_answers
  has_many :question_answers, through: :quizz_question_answers
  has_many :flashcards, through: :quizz_question_answers
  has_one :theme, through: :category
  has_one :theme_level, through: :category
  has_many :quizz_level_progresses, through: :quizz_levels
  has_many :records, through: :quizz_levels

  validates :name, presence: true
  validates :ordering, presence: true
  validates :crown_or_sphere, presence: true
  validates :crown_or_sphere, inclusion: { in: %w(crown sphere) }
end
