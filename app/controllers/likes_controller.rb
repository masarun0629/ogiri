class LikesController < ApplicationController
  before_action :set_answer, only: [:create,:destroy]
  def create
    like = current_user.likes.new(answer_id: @answer.id)
    like.save
    redirect_to  question_answers_path
  end

  def destroy
    like = current_user.likes.find_by(answer_id: @answer.id)
    like.destroy
    redirect_to  question_answers_path
  end

  private
  def set_answer
    @answer = Answer.find(params[:answer_id])
  end 
end
