class Category < ApplicationRecord
  belongs_to :subtheme
  has_one :theme, through: :subtheme
  has_many :category_progresses
  has_one_attached :photo
  has_many :quizzs, class_name: :Quizz
  has_many :quizz_levels, through: :quizzs
  has_many :question_answers, through: :quizzs

  validates :name, presence: true
end
