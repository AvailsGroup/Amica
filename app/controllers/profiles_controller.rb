class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @mates = current_user.followings_list
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
end