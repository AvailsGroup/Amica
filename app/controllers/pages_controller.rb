class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
    @mates = current_user.matchers

  end

  def show
    @user = current_user
  end

  def user
    search_text = params[:name]
    @result = Array.new
    current_user.matchers.each do |user|
      if user.name.include?(search_text)
        @result.push(user)
      end
    end

  end

  def community

  end


end
