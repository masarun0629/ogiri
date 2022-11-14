class AnswersController < ApplicationController
 
 def index
  @question = Question.find(params[:question_id])
  if params[:like_count]
    @answers = @question.answers.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
  else
    @answers = @question.answers.all.order(created_at: :desc)
  end  
  @answer = Answer.new
 end
 
 def create
  @question = Question.find(params[:question_id])
  @answers = @question.answers.order(created_at: :desc)
  @answer = Answer.new(answer_params)
  if @answer.save
    redirect_to  question_answers_path
  else
    #render :index
    redirect_back(fallback_location: root_path)
  end    
 end
 
 def destroy
  answer = Answer.find(params[:id])
  answer.destroy
  redirect_back(fallback_location: root_path)
 end
 
 private
  def answer_params
    params.require(:answer).permit(:answer).merge(user_id: current_user.id,question_id: params[:question_id])
  end
end
