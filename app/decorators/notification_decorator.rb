class NotificationDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def icon
    case object.action
    when 'community_chat' then "<i class='fas fa-users'></i>".gsub(/\r\n|\r|\n/, '<br />').html_safe
    when 'comment' then "<i class='fas fa-comment-alt'></i>".gsub(/\r\n|\r|\n/, '<br />').html_safe
    when 'like' then "<i class='fas fa-heart'></i>".gsub(/\r\n|\r|\n/, '<br />').html_safe
    when 'follow' then "<i class='fas fa-user-plus'></i>".gsub(/\r\n|\r|\n/, '<br />').html_safe
    when 'chat' then "<i class='fas fa-comment-medical'></i>".gsub(/\r\n|\r|\n/, '<br />').html_safe
    else
      '<i class="fas fa-ellipsis-h"></i>'.gsub(/\r\n|\r|\n/, '<br />').html_safe
    end
  end

end
