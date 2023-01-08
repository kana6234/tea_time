class Public::PostsController < Public::BaseController
  def show
    @posts = Post.where(user_id: params[:user_id])
  end
end
