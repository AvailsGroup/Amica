module ProfileHelper
  def block_color(user)
    blocked?(current_user, user) ? 'blue' : 'red'
  end
end
