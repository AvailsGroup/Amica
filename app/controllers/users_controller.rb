class UsersController < ApplicationController
  mount_uploader :image, ImageUploader
  before_action :authenticate_user!
  before_action :banned
  def controller
    params.require(:user).permit(:image)
  end

  attr_accessor :image_x
  attr_accessor :image_y
  attr_accessor :image_w
  attr_accessor :image_h
end
