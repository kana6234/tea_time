class Public::Tags::ItemsController < ApplicationController
  def index
    @tags = Tag.eager_load(:items).where.not(items: { id: nil}).sort {|a,b| b.items.size <=> a.items.size}
  end

  def show
    tag = Tag.find(params[:id])
    @items = tag.items
    @item = @items.recent.page(params[:page])
    @tags = Tag.eager_load(:items).where(tea_name: true).where.not(items: { id: nil})
  end
end
