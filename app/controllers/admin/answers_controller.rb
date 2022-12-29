class Admin::AnswersController < ApplicationController
  def destroy
    binding.pry
    Answer.find(params[:id]).destroy
    redirect_to admin_question_path(params[:question_id])
  end
end
