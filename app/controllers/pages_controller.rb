class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
    @mates = current_user.matchers
    @favorites = @mates.select {|e| current_user.is_user_favorite?(current_user,e)}
    @community = community_contents

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
  end

  def community
    pp params[:name]
    @result = []
    community_c = community_contents
    unless params[:name] == ""
      community_c.each do |c|
        pp c.name
        if c.name.downcase.include?(params[:name].downcase)
          @result.push(c)
        end
      end
    end
  end

  private

  def community_contents
      @community = Community.includes([:community_members,:tags]).where(id:current_user.community_member.select(:community_id)).order(created_at: :desc)
    end
  end
