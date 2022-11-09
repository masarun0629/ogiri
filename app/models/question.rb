class Question < ApplicationRecord
  validates :question,presence: true
  
  belongs_to :user
  has_one_attached :image
end
