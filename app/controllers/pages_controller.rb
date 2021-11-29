class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
    @mates = current_user.matchers
  end

  def show
    @user = current_user
  end


end
