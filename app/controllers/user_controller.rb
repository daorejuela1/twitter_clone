class UserController < ApplicationController
  before_action :get_user, only: [:show]
  def show
  end

  def edit
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user.username), notice: 'Updated succesfully'
    else
      render :edit
    end
  end

  private

  def get_user
    @user = User.find_by(username: params[:username])
  end

  def user_params
     params.require(:user).permit(:fullname, :avatar, :description, :username)
  end
end
