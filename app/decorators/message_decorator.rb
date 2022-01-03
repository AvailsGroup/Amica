class MessageDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def image
    object.image.attached? ? object.image[0] : nil
  end

  def time
    object.created_at.to_date == Date.today ? object.created_at.strftime('今日 %H:%M') : message.created_at.strftime('%H:%M')
  end

  def files
    object.file_name.nil? ? nil : "/chats/room#{object.room_id}/files/#{object.file_name}"
  end

  def type
    case object.content_type
    when 'text'
      object.content.delete("\n").slice(0..50)
    when 'image'
      '画像を送信しました。'
    else
      'ファイルを送信しました。'
    end
  end
end
