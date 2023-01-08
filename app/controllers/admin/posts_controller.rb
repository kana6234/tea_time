class Admin::PostsController < Admin::BaseController
  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_top_path
  end
end
