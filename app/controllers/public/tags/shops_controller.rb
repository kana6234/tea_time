class Public::Tags::ShopsController < ApplicationController
  def index
    @tags = Tag.joins(:shops).where("shops.id IS NOT NULL").includes(:shops).sort {|a,b| b.shops.size <=> a.shops.size}
  end

  def show
    tag = Tag.find(params[:id])
    @shops = tag.shops
  end
end
