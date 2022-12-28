class Public::QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if params[:question][:tag_names].present? && @question.save
      sent_tag_names = params[:question][:tag_names].split(/[[:blank:]]+/)
      @question.save_tags(sent_tag_names)
      redirect_to question_path(@question.id)
    else
      render :new
    end
  end

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to questions_path
  end

  def search
    if params[:keyword].present?
      @questions = Question.where('content LIKE ?', "%#{params[:keyword]}%")
    else
      redirect_to questions_path
    end
  end

  private
  def question_params
    params.require(:question).permit(:content)
  end
end
