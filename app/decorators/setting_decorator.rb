class SettingDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def student_id_value
    object.visible_student_id ? '非表示にする' : '表示する'
  end

  def enrolled_year_value
    object.visible_enrolled_year ? '非表示にする' : '表示する'
  end

end
