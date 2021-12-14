def create
  @user = current_user
  @micropost = Micropost.find(params[:micropost_id])
  current_user.like(@micropost)
  #通知機能追加
  @micropost.create_notification_like!(current_user)
  respond_to do |format|
    format.html { redirect_back(fallback_location: root_url) }
    format.js
  end
end
