class Public::RecipesController < Public::BaseController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  def new
    @recipe = Recipe.new
    @recipe.build_post
    @recipe.steps.build
    @recipe.materials.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.post.user_id = current_user.id
    if params[:recipe][:tag_names].present? && @recipe.save
      sent_tag_names = params[:recipe][:tag_names].split(/[[:blank:]]+/)
      @recipe.post.save_tags(sent_tag_names)
      redirect_to recipe_path(@recipe.id)
    else
      render :new
    end
  end

  def index
    @recipes = Recipe.recent
    @tags = Tag.eager_load(:recipes).where(tea_name: true).where.not(recipes: { id: nil})
  end

  def show
    @recipe = Recipe.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if params[:recipe][:tag_names].present? && @recipe.update(recipe_params)
      sent_tag_names = params[:recipe][:tag_names].split(/[[:blank:]]+/)
      @recipe.post.save_tags(sent_tag_names)
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
      recipes = Recipe.pluck(:post_id)
      @posts = Post.where('catchphrase || title LIKE ?', "%#{params[:keyword]}%").where(id: recipes)
    else
      redirect_to recipes_path
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:serves,
    post_attributes: [:id, :title, :catchphrase, :thumbnail_image, :introduction],
    steps_attributes: [:id, :content, :image, :_destroy],
    materials_attributes: [:id, :name, :quantity, :_destroy])
  end

  def is_matching_login_user
    recipe = Recipe.find_by(id: params[:id])
    if current_user.id != recipe.post.user_id
      redirect_to recipes_path
    end
  end
end
