class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
  end

  def show
    @invited_user = User.find_by(userid: params[:id])
    if @room.nil?
      in_room?
    end
    @user = current_user
    @room_id = @room.id
    @message = Message.all
  end
end

private

def in_room?
  @room = Room.find_by(started_userid: current_user.id, invited_userid: @invited_user.id)
  if @room.nil?
    @room = Room.find_by(started_userid: @invited_user.id, invited_userid: current_user.id)
    if @room.nil?
      Room.create(started_userid: current_user.id, invited_userid: @invited_user.id)
      @room = Room.find_by(started_userid: current_user.id, invited_userid: @invited_user.id)
    end
  end
end