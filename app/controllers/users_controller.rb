class UsersController < ApplicationController
  
  def show
    @users = User.all
    @user = User.find(params[:id])
  end
  
  def edit
  end  

end



