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
    @f_name = nil
    @image_name = nil
    unless File.directory?("#{Rails.root}/public/chats")
      Dir.mkdir("#{Rails.root}/public/chats/")
    end
    if data['message'][0..4] == 'data:'
      unless File.directory?("#{Rails.root}/public/chats/room#{@room_id}")
        Dir.mkdir("#{Rails.root}/public/chats/room#{@room_id}")
      end
      unless File.directory?("#{Rails.root}/public/chats/room#{@room_id}/files")
        Dir.mkdir("#{Rails.root}/public/chats/room#{@room_id}/files")
      end
      r_end = data['message'].index(',')
      n_start = data['message'].index('@')
      if r_end.nil? || n_start.nil?
        @content = data['message']
      else
        @base64 = data['message'][r_end.to_i + 1..n_start.to_i - 1]
        if data['message'][0..10] == 'data:image/'
          rand = rand(1_000_000..9_999_999)
          @image_name = "#{@user_id}#{rand}.jpg"
          File.open("public/chats/room#{@room_id}/files/#{@image_name}", 'wb') do |f|
            f.write(Base64.decode64(@base64))
          end
          @content = '画像を投稿しました。'
          @message = Message.new
          f = File.open("public/chats/room#{@room_id}/files/#{@image_name}")
          @message.file.attach(io: f, filename: @f_name)
          f.close
          File.delete("public/chats/room#{@room_id}/files/#{@image_name}")
        else
          @f_name = data['message'][n_start.to_i + 1..data['message'].length - 1]
          File.open("public/chats/room#{@room_id}/files/#{@f_name}", 'wb') do |f|
            f.write(Base64.decode64(@base64))
          end
          @content = "#{@f_name}を送信しました。"
          @message = Message.new
          f = File.open("public/chats/room#{@room_id}/files/#{@f_name}")
          @message.file.attach(io: f, filename: @f_name)
          f.close
          File.delete("public/chats/room#{@room_id}/files/#{@f_name}")
        end
      end
    else
      @content = data['message']
    end
    @message = Message.create content: @content, user_id: @user_id, room_id: @room_id, image: @image_name, file_name: @f_name
    @message.save
    @room = Room.find_by(id: @room_id).touch(:created_at)
    ActionCable.server.broadcast 'chat_channel', @message
  end
end

