class Public::AnswersController < ApplicationController
  def create
    answer = current_user.answers.new(answer_params)
    answer.question_id = params[:question_id]
    answer.save
    redirect_to question_path(params[:question_id])
  end

  def destroy
    Answer.find(params[:format]).destroy
    redirect_to question_path(params[:question_id])
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
