class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
    @mates = current_user.matchers
    @favorites = @mates.select {|e| current_user.is_favorite?(current_user,e)}

  end

  def show
    @user = current_user
  end

  def user
    @mates = []
    unless params[:name] == ""
      current_user.matchers.each do |u|
        if u.name.downcase.include?(params[:name].downcase) || u.nickname.downcase.include?(params[:name].downcase) || u.userid.downcase.include?(params[:name].downcase)
          @mates.push(u)
        end
      end
    end

    render 'pages/user'
  end

  def community

  end


end
