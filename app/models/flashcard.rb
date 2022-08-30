class Flashcard < ApplicationRecord
  belongs_to :user
  belongs_to :question_answer
  has_one :theme, through: :question_answer

  validates :interval, numericality: {greater_than_or_equal_to: 0}
  validates :mistake_count, numericality: {greater_than_or_equal_to: 0}
  validates :repetition, numericality: {greater_than_or_equal_to: 0}


end
