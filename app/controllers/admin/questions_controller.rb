class Admin::QuestionsController < Admin::BaseController
  def index
    @questions = Question.recent.page(params[:page])
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to admin_questions_path
  end
end
