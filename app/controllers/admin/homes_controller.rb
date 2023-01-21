class Admin::HomesController < Admin::BaseController
  def top
    @posts = Post.recent
  end
end
