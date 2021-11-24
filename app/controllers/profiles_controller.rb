class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @friends = current_user.matchers
    @following = current_user.followings_list
    @follower = current_user.followers_list
    @users = User.all
  end

  def show
    @user = User.find_by(userid: params[:id])
    if @user == nil
      redirect_to profiles_path, notice: "そのユーザーidは存在しませんでした"
    end
  end

  def search
    redirect_to profile_path(params[:name])
  end

  def friends
    @friends = current_user.matchers
  end

  def follower
    @follower = current_user.followers_list
  end

  def follow
    @following = current_user.followings_list
  end
end