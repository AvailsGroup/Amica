class UsersController < ApplicationController
  def controller
    params.require(:user).permit(:image)
  end

end
