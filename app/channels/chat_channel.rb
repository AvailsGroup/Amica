class ChatChannel < ApplicationCable::Channel
  require 'fileutils'
  include Rails.application.routes.url_helpers

  def subscribed
    stream_from 'chat_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    room = Room.find_by(id: data['room_id'])
    if room.started_user_id == current_user.id || room.invited_user_id == current_user.id
      @room_id = data['room_id']
      @image_name, @url, @f_name = nil
      @type = data['content_type']
      @content = data['message']
      Dir.mkdir("#{Rails.root}/tmp/chats/") unless File.directory?("#{Rails.root}/tmp/chats")
      unless File.directory?("#{Rails.root}/tmp/chats/room#{@room_id}")
        Dir.mkdir("#{Rails.root}/tmp/chats/room#{@room_id}")
      end
      if @type == 'file'
        start = data['message'].index(',')
        @base64 = @content[start.to_i + 1..data['message'].length - 1]
        if @content[0..10] == 'data:image/'
          rand = rand(1_000_000..9_999_999)
          @image_name = "#{rand}.jpg"
          File.open("#{Rails.root}/tmp/chats/room#{@room_id}/#{@image_name}", 'wb+') do |f|
            f.write(Base64.decode64(@base64))
          end
          f = File.open("#{Rails.root}/tmp/chats/room#{@room_id}/#{@image_name}")
          Message.first.images.attach(io: f, filename: @image_name)
          f.close
          File.delete("#{Rails.root}/tmp/chats/room#{@room_id}/#{@image_name}")
          @type = 'image'
          @url = url_for(ActiveStorage::Blob.find_by(filename: @image_name))
        else
          @f_name = data['file_name']
          File.open("#{Rails.root}/tmp/chats/room#{@room_id}/#{@f_name}", 'wb+') do |f|
            f.write(Base64.decode64(@base64))
          end
          f = File.open("#{Rails.root}/tmp/chats/room#{@room_id}/#{@f_name}")
          Message.first.files.attach(io: f, filename: @f_name)
          f.close
          File.delete("#{Rails.root}/tmp/chats/room#{@room_id}/#{@f_name}")
          @url = rails_blob_url(ActiveStorage::Blob.find_by(filename: @f_name), disposition: 'attachment')
        end
        @content = 'content'
      end
      @message = Message.create content: @content, user_id: current_user.id, room_id: @room_id, image: @image_name,
                                file_name: @f_name, url: @url, content_type: @type

      room = Room.find_by(id: @room_id)

      other_user_id = room.started_user_id == current_user.id ? room.invited_user_id : room.started_user_id

      unless Notification.exists?(visitor_id: current_user.id, visited_id: other_user_id, action: 'chat', checked: false)
        Notification.create(visitor_id: current_user.id, visited_id: other_user_id, action: 'chat')
      end

      @room = room.touch(:created_at)
      ActionCable.server.broadcast 'chat_channel', @message
      end
  end
end



