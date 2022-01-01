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
    pp data
    @room_id = data['room_id']
    @user_id = current_user.id
    @image_name, @url, @f_name = nil
    @type = data['content_type']
    @content = data['message']
    Dir.mkdir("#{Rails.root}/tmp/chats/") unless File.directory?("#{Rails.root}/tmp/chats")

    if @type == 'file'
      unless File.directory?("#{Rails.root}/tmp/chats/room#{@room_id}")
        Dir.mkdir("#{Rails.root}/tmp/chats/room#{@room_id}")
      end
      r_end = data['message'].index(',')
      n_start = data['message'].index('@')
      unless r_end.nil? || n_start.nil?
        @base64 = data['message'][r_end.to_i + 1..n_start.to_i - 1]
        if data['message'][0..10] == 'data:image/'
          rand = rand(1_000_000..9_999_999)
          @image_name = "#{rand}.jpg"
          File.open("#{Rails.root}/tmp/chats/room#{@room_id}/#{@image_name}", 'wb+') do |f|
            f.write(Base64.decode64(@base64))
          end
          @type = 'image'
          f = File.open("#{Rails.root}/tmp/chats/room#{@room_id}/#{@image_name}")
          Message.first.images.attach(io: f, filename: @image_name)
          f.close
          File.delete("#{Rails.root}/tmp/chats/room#{@room_id}/#{@image_name}")
          file = ActiveStorage::Blob.find_by(filename: @image_name)
          @url = url_for(file)
        else
          @f_name = "#{data['message'][n_start.to_i + 1..data['message'].length - 1]}"
          File.open("#{Rails.root}/tmp/chats/room#{@room_id}/#{@f_name}", 'wb+') do |f|
            f.write(Base64.decode64(@base64))
          end
          @type = 'file'
          f = File.open("#{Rails.root}/tmp/chats/room#{@room_id}/#{@f_name}")
          Message.first.files.attach(io: f, filename: @f_name)
          f.close
          File.delete("#{Rails.root}/tmp/chats/room#{@room_id}/#{@f_name}")
          file = ActiveStorage::Blob.find_by(filename: @f_name)
          @url = rails_blob_url(file, disposition: 'attachment')
        end
      end
      @content = nil
    end
    @message = Message.create content: @content, user_id: @user_id, room_id: @room_id, image: @image_name,
                              file_name: @f_name, url: @url, content_type: @type
    @room = Room.find_by(id: @room_id).touch(:created_at)
    ActionCable.server.broadcast 'chat_channel', @message

  end
end



