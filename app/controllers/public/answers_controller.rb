class Public::AnswersController < ApplicationController
  def create
    answer = current_user.answers.new(answer_params)
    answer.question_id = params[:question_id]
    if answer.save
      answer.create_notification_answer!(current_user)
    end
    redirect_to question_path(params[:question_id])
  end

  def show
    answers = Answer.where(user_id: current_user.id).pluck(:question_id)
    @questions = Question.find(answers)
  end

  def destroy
    Answer.find(params[:id]).destroy
    redirect_to question_path(params[:question_id])
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
