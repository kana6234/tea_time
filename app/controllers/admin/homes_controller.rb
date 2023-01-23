class Admin::HomesController < Admin::BaseController
  def top
    @posts = Post.recent.page(params[:page])
  end
end
