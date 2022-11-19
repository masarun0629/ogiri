class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index,:show]
  def index
    if params[:like_average]
      answer_like_count = {}
      User.all.each do |user|
        if user.answers.present?
          answer_like_count.store(user, Like.where(answer_id: Answer.where(user_id: user.id).pluck(:id)).count/user.answers.count.to_f)
        end
      end
      @user_answer_like_ranks = answer_like_count.sort_by { |_, v| v }.reverse.to_h.keys
    else 
      answer_like_count = {}
      User.all.each do |user|
        answer_like_count.store(user, Like.where(answer_id: Answer.where(user_id: user.id).pluck(:id)).count)
      end
      @user_answer_like_ranks = answer_like_count.sort_by { |_, v| v }.reverse.to_h.keys
    end
  end
  
  def show
    @user = User.find(params[:id])
    @user_answers = @user.answers
    @likes_count = 0
    @user_answers.each do |answer|
      @likes_count += answer.likes.count
    end
    answer_like_count = {}
    User.all.each do |user|
      answer_like_count.store(user, Like.where(answer_id: Answer.where(user_id: user.id).pluck(:id)).count)
    end
    @user_answer_like_ranks = answer_like_count.sort_by { |_, v| v }.reverse.to_h.keys
  end
  
  private
  def set_user
    @users = User.all
  end 
end



