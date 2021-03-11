class FollowsController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow]
  before_action :get_user

  def show_following
    @following = @user.following.paginate(page: params[:page], per_page: 10).order('fullname DESC')
  end

  def show_followers
    @followers = @user.followers.paginate(page: params[:page], per_page: 10).order('fullname DESC')
  end

  def follow
    if @user.nil?
      redirect_to request.referer, alert: 'That user does not exist!'
    elsif current_user.following.include? @user
      redirect_to request.referer, alert: "You are already following @#{@user.username}"
    else
    @user.follower_relationships.create(user_id: current_user.id)
    redirect_to user_path(@user.username), notice: "You are now following @#{@user.username}"
    end
  end

  def unfollow
    @user.follower_relationships.find_by(user_id: current_user).destroy
    redirect_to user_path(@user.username), notice: "You are not following @#{@user.username} anymore"
  end

  private
  def get_user
    @user = User.find_by(username: params[:username])
  end
end
