class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :theme_level_progresses
  has_many :subtheme_progresses
  has_many :flashcards
  has_many :category_progresses
  has_many :quizz_level_progresses
  has_many :quizz_progresses
  has_many :records
  has_many :quizz_answers
  has_many :user_answers
  has_many :achievements
  has_many :user_achievements



  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 15}

  # device gem handle mail lower case
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true




end
