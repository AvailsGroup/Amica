module ProfileHelper
  def block_color(user)
    blocked?(current_user, user) ? 'blue' : 'red'
  end

  def badge_color(rare)
    return 'gold' if rare == 'very_high'

    return 'red' if rare == 'high'

    return 'greenyellow' if rare == 'middle'

    return 'deepskyblue' if rare == 'low'

    'rgba(29,144,190,0.8)'
  end
end
