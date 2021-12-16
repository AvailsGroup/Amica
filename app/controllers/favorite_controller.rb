class FavoriteController < ApplicationController
  def user_create
    Favorite.create(user_id: current_user.id, favorite_user_id: params[:page_id])
    redirect_to pages_path, notice: "お気に入り登録しました!"
  end

  def user_destroy
    Favorite.find_by(user_id: current_user.id, favorite_user_id: params[:page_id]).destroy
    redirect_to pages_path, notice: "お気に入り登録を解除しました！"
  end

  def community_create
    Favorite.create!(user_id: current_user.id, community_id: params[:page_id])
    redirect_to pages_path, notice: "お気に入り登録しました!"
  end

  def community_destroy
    Favorite.find_by!(user_id: current_user.id, community_id: params[:page_id]).destroy
    redirect_to pages_path, notice: "お気に入り登録を解除しました！"
  end
end
