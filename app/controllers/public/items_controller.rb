class Public::ItemsController < ApplicationController
  def new
    @item = Item.new
    @item.build_post
  end

  def create
    @item = Item.create(item_params)
    @item.post.user_id = current_user.id
    if @item.save
      redirect_to item_path(@item.id)
    else
      render :new
    end
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end

  def search
    if params[:keyword].present?
      post = Post.where(postable_type: "Item")
      @posts = post.where('catchphrase || title LIKE ?', "%#{params[:keyword]}%")
    else
     redirect_to items_path
    end
  end

  private
  def item_params
    params.require(:item).permit(:website, images: [],
    post_attributes: [:id, :title, :catchphrase, :thumbnail_image, :introduction])
  end
end
