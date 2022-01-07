class CommunityMessageDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end


  def time
    object.created_at.to_date == Date.today ? object.created_at.strftime('今日 %H:%M') : message.created_at.strftime('%H:%M')
  end
end
