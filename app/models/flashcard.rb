class Flashcard < ApplicationRecord
  belongs_to :user
  belongs_to :question_answer
  has_one :theme, through: :question_answer

  validates :interval, numericality: {greater_than: 0}
  validates :mistake_count, numericality: {greater_than: 0}
  validates :repetition, numericality: {greater_than: 0}
end
