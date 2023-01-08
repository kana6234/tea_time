class Public::AnswersController < Public::BaseController
  before_action :is_matching_login_user, only: [:destroy]
  def create
    answer = current_user.answers.new(answer_params)
    answer.question_id = params[:question_id]
    if answer.save
      answer.create_notification_answer!(current_user)
    end
    redirect_to question_path(params[:question_id])
  end

  def show
    answers = Answer.where(user_id: params[:user_id]).pluck(:question_id)
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

  def is_matching_login_user
    answer = Answer.find_by(id: params[:id])
    if current_user.id != answer.user_id
      redirect_to question_path(params[:question_id])
    end
  end
end
