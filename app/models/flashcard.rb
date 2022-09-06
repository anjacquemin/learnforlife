class Flashcard < ApplicationRecord
  belongs_to :user
  belongs_to :question_answer
  belongs_to :theme
  belongs_to :category
  has_many :flashcard_saves, class_name: :FlashcardSave

  validates :interval, numericality: {greater_than_or_equal_to: 0}
  validates :mistake_count, numericality: {greater_than_or_equal_to: 0}
  validates :repetition, numericality: {greater_than_or_equal_to: 0}


  # "New Cards" tab
  NEW_STEPS = [1, 10]  # in minutes
  GRADUATING_INTERVAL = 1  # in days
  EASY_INTERVAL = 4  # in days
  STARTING_EASE = 250  # in percent

  # "Reviews" tab
  EASY_BONUS = 130  # in percent
  INTERVAL_MODIFIER = 100  # in percent
  MAXIMUM_INTERVAL = 36500  # in days

  # "Lapses" tab
  LAPSES_STEPS = [10]  # in minutes
  NEW_INTERVAL = 70  # in percent
  MINIMUM_INTERVAL = 1  # in days
end
