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
    sent_tag_names = params[:recipe][:tag_names].split(/[[:blank:]]+/)
    if sent_tag_names.blank? || sent_tag_names.size > 10
      render :new
    elsif @recipe.save
      @recipe.post.save_tags(sent_tag_names)
      redirect_to recipe_path(@recipe.id)
    else
      render :new
    end
  end

  def index
    @recipes = Recipe.all
    @recipe = Recipe.recent.page(params[:page])
    @tags = Tag.tea_name.is_recipe
  end

  def show
    @recipe = Recipe.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @tags = @recipe.post.tags.tags_join
  end

  def update
    @recipe = Recipe.find(params[:id])
    sent_tag_names = params[:recipe][:tag_names].split(/[[:blank:]]+/)
    if sent_tag_names.blank? || sent_tag_names.size > 10
      render :edit
    elsif @recipe.update(recipe_params)
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
      posts = Post.search(params[:keyword])
      @recipes = Recipe.where(post_id: posts.ids)
      @recipe = @recipes.recent.page(params[:page])
      @tags = Tag.tea_name.is_recipe
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
