class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.recent.page(params[:page]).per(60)
  end

  def update
    tag = Tag.find(params[:id])
    tag.update(tag_params)
    redirect_to admin_tags_path
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:tea_name)
  end
end
