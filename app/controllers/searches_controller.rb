class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def tag
    @users = User.tagged_with(params[:search_id])
    @communities = Community.tagged_with(params[:search_id])
  end

  def user
    @user = User.includes(:profile, :tags, :taggings)
    @users = []
    unless params[:name] == ""
      @user.each do |u|
        unless u == current_user
          unless u.name.nil?
            if u.name.downcase.include?(params[:name].downcase) || u.nickname.downcase.include?(params[:name].downcase) || u.userid.downcase.include?(params[:name].downcase)
              @users.push(u)
            end
          end
        end
      end
    end
  end

  def community
    @community = Community.includes(:community_members)
    @communities = []
    unless params[:name] == ""
      @community.each do |c|
        unless c == current_user
          if c.name.downcase.include?(params[:name].downcase)
            @communities.push(c)
          end
        end
      end
    end
  end
end
