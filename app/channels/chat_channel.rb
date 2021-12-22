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
    if data['message'][0..21] == 'data:image/jpeg;base64'
      unless File.directory?("#{Rails.root}/public/chats/room#{@room_id}")
        Dir.mkdir("#{Rails.root}/public/chats/room#{@room_id}")
      end
      rand = rand(1_000_000..9_999_999)
      @image_data = "#{@user_id}#{rand}.jpg"
      File.open("public/chats/room#{@room_id}/#{@image_data}", 'wb') do |f|
        f.write(Base64.decode64(data['message']['data:image/jpeg;base64,'.length..-1]))
      end
      @content = '画像を投稿しました。'
    elsif data['message'][0..15] == 'data:application'
      unless File.directory?("#{Rails.root}/public/chats/room#{@room_id}")
        Dir.mkdir("#{Rails.root}/public/chats/room#{@room_id}")
      end
      start = data['message'].index('data:application')
      ends = data['message'].index(',')
      @replace = data['message'][start..ends]
      File.open("public/chats/room#{@room_id}/test.docx", 'wb') do |f|
        f.write(Base64.decode64(data['message'][@replace.length..-1]))
      end
      @content = 'ファイルを投稿しました。'
    else
      @content = data['message']
      @image_data = nil
    end
    @message = Message.create content: @content, user_id: @user_id, room_id: @room_id, image: @image_data, file_name: "@file_name"
    @message.save
    @room = Room.find_by(id: @room_id).touch(:created_at)
    ActionCable.server.broadcast 'chat_channel', @message
  end
end
