class UsersController < ApplicationController
  
  def show
    @users = User.all
    @user = User.find(params[:id])
    @user_answers_likes = @user.answers.includes(:liked_users)
  end

end



