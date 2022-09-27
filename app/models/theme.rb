class Theme < ApplicationRecord
  validates :name, presence: true
  has_many :theme_levels
  has_many :subthemes, through: :theme_levels
  has_many :categories, class_name: :Category, through: :theme_levels
  has_many :quizz_levels, through: :theme_levels
  has_many :question_answers, through: :theme_levels
  has_many :best_records
  has_many :flashcards

  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
  validates :image_src, presence: true
  validates :adventure_only, inclusion: [true, false]

end
