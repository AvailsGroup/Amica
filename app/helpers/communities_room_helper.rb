module CommunitiesRoomHelper

  def chat_content(message)
    return content_image(message) if message.content_type == 'image'

    return content_file(message) if message.content_type == 'file'

    link(h(message.content).html_safe).gsub(/\r\n|\r|\n/, '<br />').html_safe
  end

end
