module CommunitiesRoomHelper
  include Rails.application.routes.url_helpers

  def chat_content(message)
    return content_image(message) if message.content_type == 'image'

    return content_file(message) if message.content_type == 'file'

    link(h(message.content).html_safe).gsub(/\r\n|\r|\n/, '<br />').html_safe
  end

  def content_image(message)
    if message.file.attached?
      image_tag url_for(message.file), style: 'max-width:100%', 'data-lity' => 'data-lity'
    else
      safe_join(message.content.split("\n"), tag(:br))
    end
  end

  def content_file(message)
    if message.file.attached?
      link_to message.file.filename, url_for(message.file), download: message.file.filename
    else
      safe_join(message.content.split("\n"), tag(:br))
    end
  end
end
