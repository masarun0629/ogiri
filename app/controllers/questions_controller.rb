class QuestionsController < ApplicationController
  
  def index
    if params[:answer_count]
      #@questions = Question.find(Answer.group(:question_id).order('count(question_id) desc').pluck(:question_id))
      @questions = Question.includes(:answers).sort {|a,b| b.answers.size <=> a.answers.size}
      #@questions = Question.includes(:answers).page(params[:page]).per(9).sort {|a,b| b.answers.size <=> a.answers.size}
      
    else
      @questions = Question.all.order(created_at: :desc)
      #@questions = Question.page(params[:page]).per(9).order(created_at: :desc)
    end
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
  
  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_back(fallback_location: root_path)
  end  

  private
  def question_params
    params.require(:question).permit(:question,:image).merge(user_id: current_user.id)
  end
end
