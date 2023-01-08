class Admin::HomesController < Admin::BaseController
  def top
    @posts = Post.all
  end
end
