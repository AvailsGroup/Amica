class ProfilesController < ApplicationController
  def index
    @mates = current_user.matchers
    @users = User.all
  end

  def show
    @user = User.find_by(userid: params[:id])
  end
end
