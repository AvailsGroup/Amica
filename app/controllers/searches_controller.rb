class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def tag
    @users = User.tagged_with(params[:search_id])
    @communities = Community.tagged_with(params[:search_id])
  end

  def user
    @user = User.includes(:profile,:tags,:taggings)
    @users = []
    unless params[:name] == ""
      @user.each do |u|
        unless u == current_user
          if u.name.downcase.include?(params[:name].downcase) || u.nickname.downcase.include?(params[:name].downcase) || u.userid.downcase.include?(params[:name].downcase)
            @users.push(u)
          end
        end
      end
    end
  end

  def community
    # @_@
  end
end
