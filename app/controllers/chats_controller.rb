class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
    latest_message?
  end

  def show
    @invited_user = User.find_by(userid: params[:id])
    if @invited_user.nil?
      redirect_to profiles_path, notice: "そのユーザーidは存在しませんでした"
      return
    end
    if @room.nil?
      in_room?
    end
    @room_id = @room.id
    @message = Message.where(room_id: @room_id)
  end
end

private

def latest_message?
  @arry = []
  @room_partner = []
  @latest_message = []
  @chatroom = Room.order(updated_at: :desc).where(started_userid: current_user.id).or(Room.order(updated_at: :desc).where(invited_userid: current_user.id))
  @chatroom.each do |cr|
    @message = Message.order(updated_at: :desc).find_by(room_id: cr.id)
    @arry << @message
  end
  @arry.each do |chat|
    @room = Room.find_by(id: chat.room_id)
    if @room.started_userid == current_user.id
      @nameid = @room.invited_userid
    else
      @nameid = @room.started_userid
    end
    @room_partner << User.find_by(id: @nameid)
    @latest_message << chat.content.delete("\n").slice(0..50)
  end
end


def in_room?
  @room = Room.find_by(started_userid: current_user.id, invited_userid: @invited_user.id)
  if @room.nil?
    @room = Room.find_by(started_userid: @invited_user.id, invited_userid: current_user.id)
    if @room.nil?
      @room = Room.create(started_userid: current_user.id, invited_userid: @invited_user.id)
      @room.save
    end
  end
end