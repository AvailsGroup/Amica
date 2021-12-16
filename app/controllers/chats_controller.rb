class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    latest_message?
  end

  def show
    @user = User.find_by(userid: params[:id])
    if @user.nil?
      redirect_to profiles_path, notice: 'そのユーザーidは存在しませんでした'
      return
    end
    in_room?
    @message = Message.where(room_id: @room.id)
  end
end

private

def latest_message?
  @room_partner = []
  @latest_message = []
  @chatroom = Room.order(updated_at: :desc).where(started_userid: current_user.id).or(Room.order(updated_at: :desc).where(invited_userid: current_user.id))
  if @chatroom.nil?
    redirect_to profiles_path, notice: '誰かとお話してみましょう！'
    return
  end
  @chatroom.each do |cr|
    @message = Message.order(updated_at: :desc).find_by(room_id: cr.id)
    if @message.nil?
      if cr.started_userid == current_user.id
        @latest_message << ''
      else
        @latest_message << nil
      end
    else
      @latest_message << @message.content.delete("\n").slice(0..50)
    end
    if cr.started_userid == current_user.id
      @userid = cr.invited_userid
    else
      @userid = cr.started_userid
    end
    @room_partner << User.find_by(id: @userid)
  end
end


def in_room?
  @room = Room.find_by(started_userid: current_user.id, invited_userid: @user.id)
  if @room.nil?
    @room = Room.find_by(started_userid: @user.id, invited_userid: current_user.id)
    if @room.nil?
      @room = Room.create(started_userid: current_user.id, invited_userid: @user.id)
      @room.save
    end
  end
end