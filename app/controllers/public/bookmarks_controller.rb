class Public::BookmarksController < Public::BaseController
  def create
    @bookmark = current_user.bookmarks.create!(question_id: params[:format])
    @bookmark.create_notification_bookmark!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def show
    bookmarks = Bookmark.recent.where(user_id: current_user.id).pluck(:question_id)
    @questions = Question.find(bookmarks)
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(question_id: params[:format])
    @bookmark.destroy
    redirect_back(fallback_location: root_path)
  end
end
