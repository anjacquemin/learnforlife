class FlashcardSave < ApplicationRecord
  belongs_to :flashcard

  validates :interval, presence: true
  validates :ease_factor, presence: true
  validates :repetition, presence: true
  validates :day_of_repetition, presence: true
  validates :auto_eval, presence: true
end
