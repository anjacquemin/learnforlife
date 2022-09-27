class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  after_initialize :set_defaults, unless: :persisted?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :level
  has_one :character, dependent: :destroy
  has_many :user_character_items, dependent: :destroy
  has_many :character_items, through: :user_character_items
  has_many :theme_level_progresses, dependent: :destroy
  has_many :subtheme_progresses, dependent: :destroy
  has_many :flashcards, dependent: :destroy
  has_many :flashcard_saves, class_name: :FlashcardSave, through: :flashcards, dependent: :destroy
  has_many :category_progresses, dependent: :destroy
  has_many :quizz_level_progresses, dependent: :destroy
  has_many :quizz_progresses, dependent: :destroy
  has_many :records
  has_many :quizz_answers
  has_many :user_answers
  has_many :user_achievements, dependent: :destroy
  has_many :achievements, through: :user_achievements



  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  #no space for user value
  validates :name, presence: true, length: { minimum: 4, maximum: 10}, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  # device gem handle mail lower case
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  validates :hp, presence: true
  validates :xp, presence: true
  validates :gem, presence: true
  validates :gold, presence: true
  validates :hp_max, presence: true
  validates :admin, inclusion: [true, false]

  def set_defaults
    self.hp ||= 50
    self.hp_max ||= 50
    self.xp ||= 0
    self.gem ||= 0
    self.gold ||= 0
  end

end
