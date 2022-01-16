class UserDecorator < ApplicationDecorator
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
    return '/assets/default_icon.png' if object.discarded?

    object.image.attached? ? object.image : '/assets/default_icon.png'
  end

  def header
    return '/assets/default_header.jpg' if object.discarded?

    object.header.attached? ? object.header : '/assets/default_header.jpg'
  end

  def image_message
    return '/assets/default_icon.png' if object.discarded?

    object.image.attached? ? object.image : '/assets/default_icon.png'
  end

  def name
    object.discarded? ? '退会済みユーザー' : object.name
  end

  def nickname
    object.discarded? ? 'Deleted User' : object.nickname
  end

  def user_blocked?(user)
    object.blocks.any? { |u| u.blocked_user_id == user.id }
  end
end
