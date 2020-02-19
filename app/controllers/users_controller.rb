class UsersController < ApplicationController
  load_and_authorize_resource

  def index; end

  def edit; end

  def show; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'updated user successfully!'
      redirect_to @user
    else
      flash[:alert] = 'update user failed!'
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:role_user)
    end
end
