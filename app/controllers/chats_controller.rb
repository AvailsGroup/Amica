class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
  end

  def show
    @user = current_user
    @message = Message.all
  end
end
