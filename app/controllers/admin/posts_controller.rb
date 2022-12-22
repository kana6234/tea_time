class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.postable.destroy
    redirect_to admin_top_path
  end
end
