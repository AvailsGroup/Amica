class FavoriteController < ApplicationController
  def user_create
    Favorite.create(user_id: current_user.id, favorite_user_id: params[:page_id])
    flash[:notice] = "お気に入り登録しました!"
    redirect_back(fallback_location: pages_path)
  end

  def user_destroy
    Favorite.find_by(user_id: current_user.id, favorite_user_id: params[:page_id]).destroy
    flash[:notice] = "お気に入り登録を解除しました!"
    redirect_back(fallback_location: pages_path)

  end

  def community_create
    Favorite.create(user_id: current_user.id, community_id: params[:page_id])
    flash[:notice] = "お気に入り登録しました!"
    redirect_back(fallback_location: pages_path)
  end

  def community_destroy
    Favorite.find_by(user_id: current_user.id, community_id: params[:page_id]).destroy
    flash[:notice] = "お気に入り登録を解除しました!"
    redirect_back(fallback_location: pages_path)
  end
end
