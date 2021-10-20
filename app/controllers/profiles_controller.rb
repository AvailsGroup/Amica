class ProfilesController < ApplicationController

  def show
    @user = User.find_by(userid: params[:id])
  end
end
