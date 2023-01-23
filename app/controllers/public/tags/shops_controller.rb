class Public::Tags::ShopsController < ApplicationController
  def index
    @tags = Tag.eager_load(:shops).where.not(shops: { id: nil}).sort {|a,b| b.shops.size <=> a.shops.size}
  end

  def show
    tag = Tag.find(params[:id])
    @shops = tag.shops
    @shop = @shops.recent.page(params[:page])
  end
end
