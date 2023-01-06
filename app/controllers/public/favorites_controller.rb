class Public::FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create!(post_id: params[:format])
    @favorite.create_notification_favorite!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def show
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def destroy
    @favorite = current_user.favorites.find_by(post_id: params[:format])
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
