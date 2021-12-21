class ChatChannel < ApplicationCable::Channel
  require 'fileutils'
  def subscribed
    stream_from 'chat_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @room_id = data['room_id']
    @user_id = current_user.id
    if !data['image'].nil?
      unless File.directory?("#{Rails.root}/public/chat_images/room#{@room_id}")
        Dir.mkdir("#{Rails.root}/public/chat_images/room#{@room_id}")
      end
      rand = rand(1_000_000..9_999_999)
      @image_data = "#{current_user.id}#{rand}.jpg"
      File.binwrite("public/chat_images/room#{@room_id}/#{@image_data}", data['image'].read)
      @image_data = data['image']
      @content = '画像を投稿しました。'
    else
      @content = data['message']
      @image_data = nil
    end
    @message = Message.create content: @content, user_id: @user_id, room_id: @room_id, image: @image_data
    @message.save
    @room = Room.find_by(id: @room_id).touch(:created_at)
    ActionCable.server.broadcast 'chat_channel', @message
  end
end