class MuteController < ApplicationController
  def create
    @post = Post.find(params[:timeline_id])
    @mute = Mute.new
    @mute.user = current_user
    @mute.post = @post
    @mute.save
    flash[:notice] = '投稿をミュートしました！'
    redirect_back fallback_location: pages_path
  end

  def destroy
    Mute.find_by(user_id: current_user.id, post_id: params[:timeline_id]).destroy
    flash[:notice] = '投稿のミュートを解除しました！'
    redirect_back fallback_location: pages_path
  end

end
