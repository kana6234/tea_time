class ApplicationController < ActionController::Base
  def check_guest
    if current_user.email == 'guest@gmail.com'
      redirect_to root_path
    end
  end
end
