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
    return 'default_icon' if object.discarded?

    object.image.attached? ? object.image : 'default_icon'
  end

  def image_message
    return 'default_icon' if object.discarded?

    object.image.attached? ? object.image : '/assets/default_icon.png'
  end

  def name
    object.discarded? ? '退会済みユーザー' : object.name
  end

  def nickname
    object.discarded? ? 'Deleted User' : object.nickname
  end
end
