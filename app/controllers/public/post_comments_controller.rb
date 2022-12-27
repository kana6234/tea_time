class Public::PostCommentsController < ApplicationController
  def create
    if params[:recipe_id].present?
      postable = Recipe.find(params[:recipe_id])
    elsif params[:shop_id].present?
      postable = Shop.find(params[:shop_id])
    else
      postable = Item.find(params[:item_id])
    end
      comment = current_user.post_comments.new(post_comment_params)
      comment.post_id = postable.post_id
      comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    PostComment.find(params[:format]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :comment_image)
  end
end
