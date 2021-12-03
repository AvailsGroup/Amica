class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
    @friends = current_user.matchers
    @following = current_user.followings_list
    @follower = current_user.followers_list
    @users = User.all
    @profile = Profile.find(current_user.id)
  end

  def show
    @profiles = Profile.find(current_user.id)
    @user = User.find_by(userid: params[:id])
    if @user.nil?
      redirect_to profiles_path, notice: "そのユーザーidは存在しませんでした"
      return
    end
    @profile = Profile.find(@user.id)
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