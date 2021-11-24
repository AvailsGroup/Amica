class FavoriteController < ApplicationController
  def create
    Favorite.create(user_id: current_user.id, favorite_user_id: params[:page_id])
    redirect_to pages_path(params[:page_id]), notice: "お気に入り登録しました!"
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, favorite_user_id: params[:page_id]).destroy
    redirect_to pages_path(params[:page_id]), notice: "お気に入り登録を解除しました！"
  end
end
