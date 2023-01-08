class Public::PostCommentsController < Public::BaseController
  before_action :is_matching_login_user, only: [:destroy]
  def create
    if params[:recipe_id].present?
      postable = Recipe.find(params[:recipe_id])
    elsif params[:shop_id].present?
      postable = Shop.find(params[:shop_id])
    else
      postable = Item.find(params[:item_id])
    end
    post_comment = current_user.post_comments.new(post_comment_params)
    post_comment.post_id = postable.post_id
    if post_comment.save
      post_comment.create_notification_post_comment!(current_user)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :comment_image)
  end

  def is_matching_login_user
    post_comment = PostComment.find_by(id: params[:id])
    if current_user.id != post_comment.user_id
      redirect_back(fallback_location: root_path)
    end
  end
end
