class Question < ApplicationRecord
  validates :question,presence: true, length: { maximum: 80 }
  
  belongs_to :user
  has_one_attached :image
  has_many  :answers , dependent: :destroy
end
