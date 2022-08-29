class BestRecord < ApplicationRecord
  belongs_to :quizz_level
  belongs_to :record
  belongs_to :theme

end
