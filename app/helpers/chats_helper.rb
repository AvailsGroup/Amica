module ChatsHelper
  require 'uri'

  def html_main_class(user)
    "message-main-#{html_sub_class(user)}"
  end

  def html_sub_class(user)
    user ? 'sender' : 'receiver'
  end

  def chat_content(message)
    return content_image(message) if message.content == '画像を送信しました。'

    return content_file(message) if message.content == 'ファイルを送信しました。'

    link(h(message.content).html_safe).gsub(/\r\n|\r|\n/, '<br />').html_safe
  end

  def content_image(message)
    image = ActiveStorage::Blob.find_by(filename: message.image)
    if image.nil?
      safe_join(message.content.split("\n"), tag(:br))
    else
      image_tag image, style: 'max-width:100%', 'data-lity' => 'data-lity'
    end
  end

  def content_file(message)
    file = ActiveStorage::Blob.find_by(filename: message.file_name)
    if file.nil?
      safe_join(message.content.split("\n"), tag(:br))
    else
      link_to message.file_name, rails_blob_url(file, disposition: 'attachment'), download: message.file_name

    end
  end

end
