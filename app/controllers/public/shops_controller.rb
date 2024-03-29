class Public::ShopsController < Public::BaseController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  def new
    @shop = Shop.new
    @shop.build_post
    @shop.business_hours.build
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.post.user_id = current_user.id
    sent_tag_names = params[:shop][:tag_names].split(/[[:blank:]]+/)
    if sent_tag_names.blank? || sent_tag_names.size > 10
      render :new
    elsif @shop.save
      @shop.post.save_tags(sent_tag_names)
      redirect_to shop_path(@shop.id)
    else
      render :new
    end
  end

  def index
    @shops = Shop.all
    @shop = Shop.recent.page(params[:page])
    @prefectures = Shop.select(:prefecture_code).distinct
  end

  def show
    @shop = Shop.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @shop = Shop.find(params[:id])
    @tags = @shop.post.tags.tags_join
  end

  def update
    @shop = Shop.find(params[:id])
    sent_tag_names = params[:shop][:tag_names].split(/[[:blank:]]+/)
    if sent_tag_names.blank? || sent_tag_names.size > 10
      render :edit
    elsif @shop.update(shop_params)
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
      posts = Post.search(params[:keyword])
      @shops = Shop.where(post_id: posts.ids)
      @shop = @shops.recent.page(params[:page])
      @prefectures = Shop.select(:prefecture_code).distinct
    else
     redirect_to shops_path
    end
  end

  def prefecture
    @shops = Shop.where(prefecture_code: params[:format])
    @shop = @shops.recent.page(params[:page])
    @prefectures = Shop.select(:prefecture_code).distinct
  end

  private
  def shop_params
    params.require(:shop).permit(:shop_name, :website, :postcode, :prefecture_code, :address, :latitude, :longitude, images: [],
    post_attributes: [:id, :title, :catchphrase, :thumbnail_image, :introduction],
    business_hours_attributes: [:id, :start_at, :finish_at, :_destroy])
  end

  def is_matching_login_user
    shop = Shop.find_by(id: params[:id])
    if current_user.id != shop.post.user_id
      redirect_to shops_path
    end
  end
end
