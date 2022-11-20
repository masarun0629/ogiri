class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:index,:create]
  
  def index
    if params[:like_count]
      answers = @question.answers.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
      @answers = Kaminari.paginate_array(answers).page(params[:page]).per(5)
    else
      @answers = @question.answers.page(params[:page]).per(5).order(created_at: :desc)
    end  
    @answer = Answer.new
  end
 
  def create
    @answers = @question.answers.order(created_at: :desc)
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to  question_answers_path
    else
      redirect_back(fallback_location: root_path)
    end      
  end
 
  def destroy
    answer = Answer.find(params[:id])
    if answer.user_id == current_user.id
      answer.destroy
      redirect_back(fallback_location: root_path)
    end  
  end
 
 private
  def answer_params
    params.require(:answer).permit(:answer).merge(user_id: current_user.id,question_id: params[:question_id])
  end
  
  def set_question
    @question = Question.find(params[:question_id])
  end 
end

