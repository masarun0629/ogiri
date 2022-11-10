class Answer < ApplicationRecord
  validates :answer,presence: true, length: { maximum: 80 }
  
  belongs_to :user
  belongs_to :question
end
