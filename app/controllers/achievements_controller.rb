class AchievementsController < ApplicationController
  def update
    @user = current_user
    if params[:id] == @user.userid
      unless Achievement.find(current_user.id)
        Achievement.new(userid: params[:id])
      end

      @achievement = Achievement.find(current_user.id)
      @achievement.update(
        communitiesCount: @communities_count,
        registrationDays: @registration_days,
        friendsCount: @friends_count,
        likesCount: @likes_count
      # ,commentsCount:
      )
    end

  end
end
