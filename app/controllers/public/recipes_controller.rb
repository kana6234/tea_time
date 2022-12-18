class Public::RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe.build_post
    @recipe.steps.build
    @recipe.materials.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.post.user_id = current_user.id
    if @recipe.save
      redirect_to recipe_path(@recipe.id)
    else
      render :new
    end
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @materials = @recipe.materials
    @steps = @recipe.steps
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe.id)
    else
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipes_path
  end

  def search
    if params[:keyword].present?
      post = Post.where(postable_type: "Recipe")
      @posts = post.where('catchphrase || title LIKE ?', "%#{params[:keyword]}%")
    else
      redirect_to recipes_path
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:serves,
    post_attributes: [:id, :title, :catchphrase, :thumbnail_image, :introduction],
    steps_attributes: [:id, :no, :content, :_destroy],
    materials_attributes: [:id, :name, :quantity, :_destroy])
  end
end
