class HomeController < ApplicationController
  def top
    render layout: nil
  end

  def about
    render layout: 'home'
  end

  def contact
    render layout: 'home'
  end
end
