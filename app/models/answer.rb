class Answer < ApplicationRecord
  validates :answer,presence: true, length: { maximum: 72 }
  
  belongs_to :user 
  belongs_to :question
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
