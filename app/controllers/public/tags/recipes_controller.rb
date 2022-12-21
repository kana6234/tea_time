class Public::Tags::RecipesController < ApplicationController
  def index
    @tags = Tag.includes(:posts).sort {|a,b| b.posts.seach_recipe.size <=> a.posts.seach_recipe.size}
  end

  def show
    tag = Tag.find(params[:id])
    @posts = tag.posts.seach_recipe
  end
end
