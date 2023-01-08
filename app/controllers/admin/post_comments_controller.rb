class Admin::PostCommentsController < Admin::BaseController
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end
end
