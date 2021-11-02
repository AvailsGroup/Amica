class RelationshipsController < ApplicationController
  def create
    @user = User.find_by(userid: params[:profile_id])
    @relationship = Relationship.new(follower_id: current_user.id, followed_id: @user.id)
    if @relationship.save!
      redirect_to profile_path(params[:profile_id]), notice: "フォローしました！"
    else
      redirect_to profile_path(params[:profile_id]), notice: "エラーが発生しました！"
    end

  end


  def destroy
    other_user = User.find_by(userid: params[:profile_id])
    current_user.unfollow(other_user)
    redirect_to profile_path(params[:profile_id]), notice: "フォローを外しました！"
  end

end