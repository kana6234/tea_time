class Public::Tags::ShopsController < ApplicationController
  def index
    @tags = Tag.includes(:posts).sort {|a,b| b.posts.seach_shop.size <=> a.posts.seach_shop.size}
  end

  def show
    tag = Tag.find(params[:id])
    @posts = tag.posts.seach_shop
  end
end
