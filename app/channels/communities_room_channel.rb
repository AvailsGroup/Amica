class CommunitiesRoomChannel < ApplicationCable::Channel
  require 'fileutils'
  include Rails.application.routes.url_helpers

  def subscribed
    stream_from "communities_room_channel_#{params['room']}"
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
    @type = data['type']
    @content = data['message']
    @file = data['file']

    make_directories(data)
    unless current_user.community_member.any? { |c| c.community_id == data['community_id'] }
      return
    end

    @community = CommunityMessage.new(content: @content, user_id: current_user.id, community_id: data['community_id'], content_type: @type)
    @community.save!

    unless @type == 'text'
      save_file(data)
    end

    community = Community.find(data['community_id'])
    member = community.community_members
    member.each do |m|
      next if(m.user == current_user)

      unless Notification.exists?(community_id: data['community_id'], visited_id: m.id, action: 'community_chat', checked: false)
        Notification.create(community_id: data['community_id'], visitor_id: current_user.id, visited_id: m.id, action: 'community_chat')
      end
    end


    CommunityMessageBroadcastJob.perform_later @community
  end

  private

  def make_directories(data)
    Dir.mkdir("#{Rails.root}/tmp/community_chats/") unless File.directory?("#{Rails.root}/tmp/community_chats")
    unless File.directory?("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}")
      Dir.mkdir("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}")
    end
  end

  def save_file(data)
    start = data['file'].index(',')
    base64 = data['file'][start + 1..data['file'].length - 1]
    File.open("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{data['file_name']}", 'wb+') do |f|
      f.write(Base64.decode64(base64))
    end
    # file_check = check_broken_file("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{data['file_name']}")
    # if data['type'] == 'image'
    #   unless file_check[0] != :unknown && file_check[1] == :clean
    #     @community.update(content_type: 'file')
    #   end
    # end

    f = File.open("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{data['file_name']}")
    @community.file.attach(io: f, filename: data['file_name'])
    f.close
    File.delete("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{data['file_name']}")

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
