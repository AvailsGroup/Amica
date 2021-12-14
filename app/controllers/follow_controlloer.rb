def create
  @user =User.find(params[:follow_relationship][:following_id])
  current_user.follow(@user)
  #通知機能追加
  @user.create_notification_follow!(current_user)
  respond_to do |format|
    format.html {redirect_back(fallback_location: root_url)}
    format.js
  end
end
