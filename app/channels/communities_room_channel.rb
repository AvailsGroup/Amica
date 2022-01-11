class CommunitiesRoomChannel < ApplicationCable::Channel
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
      r_end = data['message'].index(',')
      n_start = data['message'].index('@')
      @base64 = @content[r_end.to_i + 1..n_start.to_i - 1]
      if @content[0..10] == 'data:image/'
        @image_name = "#{rand(1_000_000..9_999_999)}.jpg"
        File.open("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@image_name}", 'wb+') do |f|
          f.write(Base64.decode64(@base64))
        end
        f = File.open("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@image_name}")
        CommunityMessage.first.images.attach(io: f, filename: @image_name)
        f.close
        File.delete("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@image_name}")
        @type = 'image'
        @url = url_for(ActiveStorage::Blob.find_by(filename: @image_name))
      else
        @f_name = (data['message'][n_start.to_i + 1..data['message'].length - 1]).to_s
        File.open("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@f_name}", 'wb+') do |f|
          f.write(Base64.decode64(@base64))
        end
        f = File.open("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@f_name}")
        CommunityMessage.first.files.attach(io: f, filename: @f_name)
        f.close
        File.delete("#{Rails.root}/tmp/community_chats/community_#{data['community_id']}/#{@f_name}")
        @url = rails_blob_url(ActiveStorage::Blob.find_by(filename: @f_name), disposition: 'attachment')
      end
      @content = 'content'
    end
    unless current_user.community_member.any? { |c| c.community_id == data['community_id'] }
      return
    end
    pp @image_name
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
end
