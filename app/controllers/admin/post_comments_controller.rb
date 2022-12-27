class Admin::PostCommentsController < ApplicationController
  def destroy
    binding.pry
    PostComment.find(params[:format]).destroy
    redirect_back(fallback_location: root_path)
  end
end
