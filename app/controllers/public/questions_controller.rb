class Public::QuestionsController < Public::BaseController
  before_action :is_matching_login_user, only: [:destroy]
  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    sent_tag_names = params[:question][:tag_names].split(/[[:blank:]]+/)
    if sent_tag_names.blank? || sent_tag_names.size > 10
      render :new
    elsif  @question.save
      @question.save_tags(sent_tag_names)
      redirect_to question_path(@question.id)
    else
      render :new
    end
  end

  def index
    @questions = Question.all
    @question = Question.recent.page(params[:page])
    @tags = Tag.find(QuestionTag.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
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
      @question = @questions.recent.page(params[:page])
      @tags = Tag.find(QuestionTag.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    else
      redirect_to questions_path
    end
  end

  private
  def question_params
    params.require(:question).permit(:content)
  end

  def is_matching_login_user
    question = Question.find_by(id: params[:id])
    if current_user.id != question.user_id
      redirect_to questions_path
    end
  end
end
