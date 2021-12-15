class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
    latest_message?

    @latest_message.each do |chat|
      chat.each do |cr|
        cr.room_id
        cr.content
      end
    end

  end

  def show
    @invited_user = User.find_by(userid: params[:id])
    if @room.nil?
      in_room?
    end
    @room_id = @room.id
    @message = Message.where(room_id: @room_id)
  end
end

private

def latest_message?
  @latest_message = []
  @chatroom = Room.where(started_userid: current_user.id).or(Room.where(invited_userid: current_user.id))
  @chatroom.each do |cr|
    @message = Message.where(room_id: cr.id)
    @latest_message << @message.order(updated_at: :desc).limit(1).to_a
  end
end

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