class Public::UsersController < ApplicationController
  before_action :check_guest, only:[:update, :withdraw]
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(deleted_params)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :introduction)
  end

  def deleted_params
    params.require(:user).permit(:is_deleted)
  end
end
