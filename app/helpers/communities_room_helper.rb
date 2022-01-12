module CommunitiesRoomHelper
  include Rails.application.routes.url_helpers

  def chat_content(message)
    return content_image(message) if message.content_type == 'image'

    return content_file(message) if message.content_type == 'file'

    link(h(message.content).html_safe).gsub(/\r\n|\r|\n/, '<br />').html_safe
  end

  def content_image(message)
    image = ActiveStorage::Blob.find_by(filename: message.image)
    if image.nil?
      safe_join(message.content.split("\n"), tag(:br))
    else
      image_tag url_for(image), style: 'max-width:100%', 'data-lity' => 'data-lity'
    end
  end

  def content_file(message)
    file = ActiveStorage::Blob.find_by(filename: message.file_name)
    if file.nil?
      safe_join(message.content.split("\n"), tag(:br))
    else
      index = message.file_name.index('-')
      link_to message.file_name.slice(index + 1..-1), url_for(file), download: message.file_name.slice(index + 1..-1)
    end
  end
end
