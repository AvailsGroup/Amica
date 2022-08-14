class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  before_action :login_limit
  helper_method :blocked?

  def index
    latest_message
    if @chatroom.nil?
      redirect_to profiles_path, notice: '誰かとお話してみましょう！'
    end

    @chat = Kaminari.paginate_array(@room_partner).page(params[:page]).per(10)
  end

  def show
    @user = User.find_by(userid: params[:id])
    if @user.nil?
      redirect_to profiles_path, notice: 'そのユーザーidは存在しませんでした'
      return
    end
    in_room?
    @messages = @room.messages
    @pagenate = @messages.order(updated_at: :desc).page(params[:page]).per(50)
  end

  private

  def latest_message
    @room_partner = []
    @latest_message = []
    @chatroom = Room.order(updated_at: :desc).where(started_user_id: current_user.id)
                    .or(Room.order(updated_at: :desc).where(invited_user_id: current_user.id))
    if @chatroom == [] || @chatroom.nil?
      @chatroom = nil
      return
    end

    @chatroom.each do |cr|
      @message = Message.order(updated_at: :desc).find_by(room_id: cr.id)
      if @message.nil?
        cr.started_user_id == current_user.id ? @latest_message << '' : @latest_message << []
      else
        @latest_message << @message
      end

      @userid = cr.started_user_id == current_user.id ? cr.invited_user_id : cr.started_user_id
      @room_partner << User.find_by(id: @userid)
    end
  end

  def in_room?
    @room = Room.find_by(started_user_id: current_user.id, invited_user_id: @user.id)
    if @room.nil?
      @room = Room.find_by(started_user_id: @user.id, invited_user_id: current_user.id)
      if @room.nil?
        @room = Room.create(started_user_id: current_user.id, invited_user_id: @user.id)
        @room.save
      end
    end
  end
end
