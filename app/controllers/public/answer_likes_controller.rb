class Public::AnswerLikesController < ApplicationController
  def create
    @answer_like = current_user.answer_likes.create!(answer_id: params[:format])
    @answer_like.create_notification_answer_like!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @answer_like = current_user.answer_likes.find_by(answer_id: params[:format])
    @answer_like.destroy
    redirect_back(fallback_location: root_path)
  end
end
