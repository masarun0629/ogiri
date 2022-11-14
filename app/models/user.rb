class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :nickname,presence: true, length: { maximum: 10 }     
  validates :profile,presence: true,length: { maximum: 100 }
  
  has_many  :questions
  has_many  :answers
  has_many :likes, dependent: :destroy
  has_many :liked_answers, through: :likes, source: :answer
  
end
