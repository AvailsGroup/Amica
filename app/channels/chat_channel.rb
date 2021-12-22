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
    unless File.directory?("#{Rails.root}/public/chats")
      Dir.mkdir("#{Rails.root}/public/chats/")
    end
    if data['message'][0..21] == 'data:image/jpeg;base64'
      unless File.directory?("#{Rails.root}/public/chats/room#{@room_id}")
        Dir.mkdir("#{Rails.root}/public/chats/room#{@room_id}")
      end
      unless File.directory?("#{Rails.root}/public/chats/room#{@room_id}/images")
        Dir.mkdir("#{Rails.root}/public/chats/room#{@room_id}/images")
      end
      rand = rand(1_000_000..9_999_999)
      @image_data = "#{@user_id}#{rand}.jpg"
      File.open("public/chats/room#{@room_id}/images/#{@image_data}", 'wb') do |f|
        f.write(Base64.decode64(data['message']['data:image/jpeg;base64,'.length..-1]))
      end
      @content = '画像を投稿しました。'
    elsif data['message'][0..15] == 'data:application'
      unless File.directory?("#{Rails.root}/public/chats/room#{@room_id}")
        Dir.mkdir("#{Rails.root}/public/chats/room#{@room_id}")
      end
      unless File.directory?("#{Rails.root}/public/chats/room#{@room_id}/files")
        Dir.mkdir("#{Rails.root}/public/chats/room#{@room_id}/files")
      end
      r_start = data['message'].index('data:application')
      r_end = data['message'].index(',')
      @replace = data['message'][r_start..r_end]
      n_start = data['message'].index('@')
      @f_replace = data['message'][n_start..data['message'].length]
      @f_name = data['message'][n_start.to_i + 1..data['message'].length - 1]
      @base64 = data['message'][r_end.to_i + 1..n_start.to_i - 1]
      File.open("public/chats/room#{@room_id}/files/#{@f_name}", 'wb') do |f|
        f.write(Base64.decode64(@base64))
      end
      @content = "【#{@f_name}】を送信しました。"
    else
      @content = data['message']
      @image_data = nil
    end
    @message = Message.create content: @content, user_id: @user_id, room_id: @room_id, image: @image_data, file_name: @f_name
    @message.save
    @room = Room.find_by(id: @room_id).touch(:created_at)
    ActionCable.server.broadcast 'chat_channel', @message
  end
end

