module NotificationsHelper

  def icon(action)
    case action
      when 'comment' then "<i class='fas fa-comment-alt'></i>"
      when 'like' then "<i class='fas fa-heart'></i>"
      when 'follow' then "<i class='fas fa-user-plus'></i>"
      else
        '<i class="fas fa-ellipsis-h"></i>'
    end
  end
end
