class Public::QuestionLikesController < Public::BaseController
  def create
    @question_like = current_user.question_likes.create!(question_id: params[:format])
    @question_like.create_notification_question_like!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @question_like = current_user.question_likes.find_by(question_id: params[:format])
    @question_like.destroy
    redirect_back(fallback_location: root_path)
  end
end
