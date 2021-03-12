class FollowsController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow]
  before_action :get_user

  def index_following
    @following = @user.following.paginate(page: params[:page], per_page: 10).order('fullname DESC')
  end

  def index_followers
    @followers = @user.followers.paginate(page: params[:page], per_page: 10).order('fullname DESC')
  end

  def create
    if @user.nil?
      redirect_to request.referer, alert: 'That user does not exist!'
    elsif current_user.following.include? @user
      redirect_to request.referer, alert: "You are already following @#{@user.username}"
    elsif current_user == @user
      redirect_to request.referer, alert: "You can not follow yourself"
    else
      @user.follower_relationships.create!(user_id: current_user.id)
      redirect_to user_path(@user.username), notice: "You are now following @#{@user.username}"
    end
  end

  def destroy
    @user.follower_relationships.find_by(user_id: current_user).destroy
    redirect_to user_path(@user.username), notice: "You are not following @#{@user.username} anymore"
  end

  private
  def get_user
    @user = User.find_by(username: params[:username])
  end
end
