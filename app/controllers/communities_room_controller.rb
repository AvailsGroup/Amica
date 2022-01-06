class CommunitiesRoomController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def show
    @messages = Message.all
  end
end
