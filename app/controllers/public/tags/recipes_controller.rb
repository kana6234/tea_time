class Public::Tags::RecipesController < ApplicationController
  def index
    @tags = Tag.joins(:recipes).where("recipes.id IS NOT NULL").includes(:recipes).sort {|a,b| b.recipes.size <=> a.recipes.size}
  end

  def show
    tag = Tag.find(params[:id])
    @recipes = tag.recipes
  end
end
