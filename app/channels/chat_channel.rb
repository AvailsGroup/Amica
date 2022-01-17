class ChatChannel < ApplicationCable::Channel
  require 'fileutils'
  include Rails.application.routes.url_helpers

  def subscribed
    stream_from 'chat_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def perform_action(data)
    Rails.logger.silence do
      super(data)
    end
  end

  def speak(data)
    room = Room.find_by(id: data['room_id'])
    unless room.started_user_id == current_user.id || room.invited_user_id == current_user.id
      return
    end

    make_directories(data)
    @content = data['message']
    @room_id = data['room_id']
    @type = data['type']
    @file = data['file']
    @message = Message.new(content: @content, user_id: current_user.id, room_id: @room_id, content_type: @type)
    @message.save!

    unless @type == 'text'
      save_file(data)
    end

    MessageBroadcastJob.perform_later @message

  end

  private

  def make_directories(data)
    Dir.mkdir("#{Rails.root}/tmp/chats/") unless File.directory?("#{Rails.root}/tmp/chats")
    unless File.directory?("#{Rails.root}/tmp/chats/room#{data['room_id']}")
      Dir.mkdir("#{Rails.root}/tmp/chats/room#{data['room_id']}")
    end
  end

  def save_file(data)
    start = data['file'].index(',')
    base64 = data['file'][start + 1..data['file'].length - 1]
    File.open("#{Rails.root}/tmp/chats/room#{data['room_id']}/#{data['file_name']}", 'wb+') do |f|
      f.write(Base64.decode64(base64))
    end
    # file_check = check_broken_file("#{Rails.root}/tmp/chats/room#{data['room_id']}/#{data['file_name']}")
    # if data['type'] == 'image'
    #   unless file_check[0] != :unknown && file_check[1] == :clean
    #     @message.update(content_type: 'file')
    #   end
    # end
    f = File.open("#{Rails.root}/tmp/chats/room#{data['room_id']}/#{data['file_name']}")
    @message.file.attach(io: f, filename: data['file_name'])
    f.close
    File.delete("#{Rails.root}/tmp/chats/room#{data['room_id']}/#{data['file_name']}")
  end

  def check_broken_file(filename)
    result = [:unknown, :clean]
    File.open(filename, 'rb') do |f|
      begin
        header = f.read(8)
        f.seek(-12, IO::SEEK_END)
        footer = f.read(12)
      rescue
        result[1] = :damaged
        return result
      end

      if header[0, 2].unpack('H*') == ['ffd8']
        result[0] = :jpg
        result[1] = :damaged unless footer[-2, 2].unpack('H*') == ['ffd9']
      elsif header[0, 3].unpack('A*') == ['GIF']
        result[0] = :gif
        result[1] = :damaged unless footer[-1, 1].unpack('H*') == ['3b']
      elsif header[0, 8].unpack('H*') == ['89504e470d0a1a0a']
        result[0] = :png
        result[1] = :damaged unless footer[-12, 12].unpack('H*') == ['0000000049454e44ae426082']
      end
    end
    result
  end
end



