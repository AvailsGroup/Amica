class HomeController < ApplicationController
  def top
    render layout: 'home'
  end

  def about
    render layout: 'home'
  end

  def contact
    render layout: 'home'
    flash.now[:notice] = 'test'
  end
end
