class Public::ShopsController < ApplicationController
  def new
    @shop = Shop.new
    @shop.build_post
    @shop.business_hours.build
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.post.user_id = current_user.id
    if params[:shop][:tag_names].present? && @shop.save
      sent_tag_names = params[:shop][:tag_names].split(/[[:blank:]]+/)
      @shop.post.save_tags(sent_tag_names)
      redirect_to shop_path(@shop.id)
    else
      render :new
    end
  end

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    if params[:shop][:tag_names].present? && @shop.update(shop_params)
      sent_tag_names = params[:shop][:tag_names].split(/[[:blank:]]+/)
      @shop.post.save_tags(sent_tag_names)
      redirect_to shop_path(@shop.id)
    else
      render :edit
    end
  end

  def destroy
    shop = Shop.find(params[:id])
    shop.destroy
    redirect_to shops_path
  end

  def search
    if params[:keyword].present?
      shops = Shop.pluck(:post_id)
      @posts = Post.where('catchphrase || title LIKE ?', "%#{params[:keyword]}%").where(id: shops)
    else
     redirect_to shops_path
    end
  end

  private
  def shop_params
    params.require(:shop).permit(:shop_name, :website, :postcode, :prefecture_code, :address, :latitude, :longitude, images: [],
    post_attributes: [:id, :title, :catchphrase, :thumbnail_image, :introduction],
    business_hours_attributes: [:id, :start_at, :finish_at, :_destroy])
  end
end
