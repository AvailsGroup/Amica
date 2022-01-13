class CommunitiesRoomChannel < ApplicationCable::Channel
  require 'fileutils'
  include Rails.application.routes.url_helpers

  def subscribed
    stream_from "communities_room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @image_name, @url, @f_name = nil
    @type = data['type']
    @content = data['message']
    make_directories(data)
    if @type == 'file'
      start = data['message'].index(',')
      @base64 = @content[start + 1..data['message'].length - 1]
      @content[0..10] == 'data:image/' ? save_image(data) : save_file(data)
      @content = 'content'
    end
    unless current_user.community_member.any? { |c| c.community_id == data['community_id'] }
      return
    end

    CommunityMessage.create(
      content: @content,
      user_id: current_user.id,
      community_id: data['community_id'],
      image: @image_name,
      file_name: @f_name,
      url: @url,
      content_type: @type
    )
  end

  def make_directories(data)
    Dir.mkdir("#{Rails.root}/tmp/community_chats/") unless File.directory?("#{Rails.root}/tmp/community_chats")
    unless File.directory?("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}")
      Dir.mkdir("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}")
    end
  end

  def save_image(data)
    rand = rand(0..999)
    @image_name = "#{Time.zone.now.strftime('%Y%m%d%H%M%S')}#{rand}.jpg"
    File.open("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@image_name}", 'wb+') do |f|
      f.write(Base64.decode64(@base64))
    end
    f = File.open("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@image_name}")
    Message.first.images.attach(io: f, filename: @image_name)
    f.close
    File.delete("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@image_name}")
    @type = 'image'
    @url = url_for(ActiveStorage::Blob.find_by(filename: @image_name))
  end

  def save_file(data)
    rand = rand(0..999)
    @f_name = "#{Time.zone.now.strftime('%Y%m%d%H%M%S')}#{rand}-#{data['file_name']}"
    File.open("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@f_name}", 'wb+') do |f|
      f.write(Base64.decode64(@base64))
    end
    f = File.open("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@f_name}")
    CommunityMessage.first.files.attach(io: f, filename: @f_name)
    f.close
    File.delete("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@f_name}")
    @url =rails_blob_url(ActiveStorage::Blob.find_by(filename: @f_name), disposition: 'attachment')
  end
end
