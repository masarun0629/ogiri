class QuestionsController < ApplicationController
  def index
    @questions = Question.all.order(created_at: :desc)
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to root_path
    else
      render :new
    end
  end  

  private
  def question_params
    params.require(:question).permit(:question,:image).merge(user_id: current_user.id)
  end
end
