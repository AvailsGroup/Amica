class TimelinesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
  end
  def show

  end
  def edit
    @user = current_user
  end
  def new

  end
  def create

  end
end
