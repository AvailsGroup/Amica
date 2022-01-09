class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  #protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def banned
    cookies.signed["user_id"] = current_user.id
    current_user.ban = true if current_user.warning >= 3

    if current_user.ban
      sign_out current_user
      flash.alert = 'あなたはアカウント停止処分を受けています。'
      redirect_to '/'
    end
  end

  def after_sign_in_path_for(resource)
    return tutorial_pages_path if resource.sign_in_count == 1

    flash[:alert] = 'ようこそAmicaへ！ '
    pages_path
  end

  def authenticate_admin_user!
    authenticate_user!

    unless current_user.admin
      flash[:notice] = "管理者用ページです。権限があるアカウントでログインしてください。"
      redirect_to pages_path
    end
  end

  def base64?(value)
    value.is_a?(String) && Base64.strict_encode64(Base64.decode64(value)) == value
  end

  def matchers(user)
    user.followings & user.followers
  end

  def matchers?(user, other_user)
    matchers(user).include?(other_user)
  end

  def blocked?(user, other_user)
    user.blocks.any? { |u| u.blocked_user_id == other_user.id }
  end

  def following?(user_followings_list, other_user)
    user_followings_list.any? { |u| u == other_user }
  end

  def liked_by?(post, user)
    post.likes.any? { |l| l.user == user }
  end

  def is_user_favorite?(favorite, user, other_user)
    favorite.any? { |u| u.user_id == user.id } && favorite.any? { |u| u.favorite_user_id == other_user.id }
  end

  def is_community_favorite?(favorite, user, community)
    favorite.any? { |u| u.user_id == user.id } && favorite.any? { |u| u.community_id == community.id }
  end

  def self.render_with_signed_in_user(user, *args)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
    renderer = self.renderer.new('warden' => proxy)
    renderer.render(*args)
  end

  private

  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:agreement_terms])
  end

end
