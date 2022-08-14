class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def banned
    current_user.ban = true if current_user.warning >= 3

    if current_user.ban
      sign_out current_user
      flash.alert = 'あなたはアカウント停止処分を受けています。'
      redirect_to '/'
    end
  end

  def login_limit
    unless current_user.admin
      sign_out current_user
      flash.alert = 'Amicaはサービスを終了しました。今までのご利用ありがとうございました。'
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

  def check_broken_file(filename)
    result = [ :unknown, :clean ]
    File.open(filename, "rb") do |f|
      begin
        header = f.read(8)
        f.seek(-12, IO::SEEK_END)
        footer = f.read(12)
      rescue
        result[1] = :damaged
        return result
      end

      if header[0,2].unpack("H*") == [ "ffd8" ]
        result[0] = :jpg
        result[1] = :damaged unless footer[-2,2].unpack("H*") == [ "ffd9" ]
      elsif header[0,3].unpack("A*") == [ "GIF" ]
        result[0] = :gif
        result[1] = :damaged unless footer[-1,1].unpack("H*") == [ "3b" ]
      elsif header[0,8].unpack("H*") == [ "89504e470d0a1a0a" ]
        result[0] = :png
        result[1] = :damaged unless footer[-12,12].unpack("H*") == [ "0000000049454e44ae426082" ]
      end
    end
    result
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
