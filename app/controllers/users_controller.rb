class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  def controller
    params.require(:user).permit(:image)
  end

end
