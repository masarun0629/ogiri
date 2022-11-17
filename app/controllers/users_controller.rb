class UsersController < ApplicationController
  
  def index
    @users = User.all
  end  
  
  def show
    @users = User.all
    @user = User.find(params[:id])
    @user_answers = @user.answers
    @likes_count = 0
    @user_answers.each do |answer|
      @likes_count += answer.likes.count
    end
  end

end



