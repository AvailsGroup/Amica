class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  #protect_from_forgery with: :exception
  before_action :block_foreign_hosts
  before_action :configure_permitted_parameters, if: :devise_controller?

  def banned
    if current_user.warning >= 3
      current_user.ban = true
    end

    if current_user.ban
      sign_out current_user
      flash.alert = 'あなたはアカウント停止処分を受けています。'
      redirect_to '/'
    end
  end

  def after_sign_in_path_for(resource)
    flash[:alert] = 'ようこそAmicaへ！ '
    pages_path
  end

  def base64?(value)
    value.is_a?(String) && Base64.strict_encode64(Base64.decode64(value)) == value
  end

  #友達の配列を返す
  def matchers(user)
    user.followings & user.followers
  end

  def matchers?(user, other_user)
    matchers(user).include?(other_user)
  end

  # 相手をフォローしていればtrueを返す
  def following?(user_followings_list, other_user)
    user_followings_list.any? { |u| u == other_user }
  end

  def liked_by?(post, user)
    post.likes.any? { |l| l.user == user }
  end

  def is_user_favorite?(favorite, user, other_user)
    favorite.any? { |u| u.user_id == user.id } && favorite.any? { |u| u.favorite_user_id == other_user.id }
  end

  def is_community_favorite?(favorite , user, community)
    favorite.any? { |u| u.user_id == user.id } && favorite.any? { |u| u.community_id == community.id }
  end

  private
  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end
  
  def whitelisted?(ip)
    %w[218.45.244.196 218.45.244.196 8.37.43.227 218.45.244.196 8.37.43.168 8.37.43.185 127.0.0.1].include?(ip)
  end
  
  def block_foreign_hosts
    redirect_to 'https://www.google.com' unless whitelisted?(request.remote_ip)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:agreement_terms])
  end



end
