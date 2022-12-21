class Public::Tags::ItemsController < ApplicationController
  def index
    @tags = Tag.includes(:posts).sort {|a,b| b.posts.seach_item.size <=> a.posts.seach_item.size}
  end

  def show
    tag = Tag.find(params[:id])
    @posts = tag.posts.seach_item
  end
end
