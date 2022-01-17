module ChatsHelper
  require 'uri'

  def index_message(message)
    return '※このユーザーとはまだ会話したことがないようです！会話してみましょう！※' if message == ''

    '※このユーザーがあなたと会話したいようです！会話してみましょう！※'
  end

  def index_date_format(message)
    if message.created_at.to_date == Date.today
      message.created_at.strftime("今日 %H:%M")
    else
      message.created_at.strftime("%m月%d日")
    end
  end

  def html_main_class(user)
    "message-main-#{html_sub_class(user)}"
  end

  def html_sub_class(user)
    user ? 'sender' : 'receiver'
  end

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

  def not_send_message(user)
    return 'ユーザーをブロックしています' if blocked?(current_user, user)

    return 'ユーザーにブロックされています' if blocked?(@user, current_user)

    return '退会済みユーザーです' if user.discarded?

    'ユーザーをフォローしてないとチャットが出来ません'
  end

end
