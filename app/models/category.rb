class Category < ApplicationRecord
  belongs_to :subtheme
  has_one :theme, through: :subtheme
  has_one :theme_level, through: :subtheme
  has_many :category_progresses
  has_many :quizzs, class_name: :Quizz
  has_many :quizz_progresses, through: :quizzs
  has_many :quizz_levels, through: :quizzs
  has_many :question_answers, through: :quizzs
  has_many :quizz_question_answers, through: :quizzs
  has_many :quizz_level_progresses, through: :quizzs
  has_many :flashcards, through: :quizzs

  has_many :records, through: :quizzs


  validates :name, presence: true
  validates :objective, presence: true
  validates :img_src, presence: true
  validates_uniqueness_of :name, scope: :subtheme

end

# ORDER BY NAME WITH SCOPE FOR CONSISTENT DISPLAY
