class Public::Tags::ItemsController < ApplicationController
  def index
    @tags = Tag.joins(:items).where("items.id IS NOT NULL").includes(:items).sort {|a,b| b.items.size <=> a.items.size}
  end

  def show
    tag = Tag.find(params[:id])
    @items = tag.items
  end
end
