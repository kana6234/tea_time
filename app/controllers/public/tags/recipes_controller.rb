class Public::Tags::RecipesController < ApplicationController
  def index
    @tags = Tag.eager_load(:recipes).where.not(recipes: { id: nil}).sort {|a,b| b.recipes.size <=> a.recipes.size}
  end

  def show
    tag = Tag.find(params[:id])
    @recipes = tag.recipes
    @recipe = @recipes.recent.page(params[:page])
  end
end
