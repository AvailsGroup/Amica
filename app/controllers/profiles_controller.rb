class ProfilesController < ApplicationController

  def show
    @users = User.find_by(userid: params[:id])
  end
end
