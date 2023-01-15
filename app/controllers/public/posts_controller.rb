class Public::PostsController < Public::BaseController
  def show
    @user = User.find(params[:user_id])
    @posts = Post.where(user_id: params[:user_id])
  end
end
