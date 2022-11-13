class Question < ApplicationRecord
  validates :question,presence: true, length: { maximum: 80 }
  
  belongs_to :user
  has_one_attached :image
  has_many  :answers , dependent: :destroy
  
  scope :latest, -> {Answer.group(:question_id).order('count(question_id) desc').pluck(:question_id)}
end
