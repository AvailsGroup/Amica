class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  helper_method :following?
  helper_method :matchers?
  helper_method :is_user_favorite?
  helper_method :blocked?

  def index
    @users = User.with_attached_image.includes(:profile, :favorite, :followers, :passive_relationships, :active_relationships, :followings, :tags)

    @user = @users.find(current_user.id)
    @friends = matchers(@user)
    @follower = @user.followers_list
    @profile = @user.profile
    sort_pickup
  end

  def show
    @users = User.includes(:profile, :favorite, :followers, :passive_relationships, :active_relationships, :followings, :posts, :tags)
    @user = @users.find_by(userid: params[:id])
    @current = @users.find(current_user.id)
    if @user.nil?
      redirect_to profiles_path, notice: 'そのユーザーidは存在しませんでした'
      return
    end
    @profile = @user.profile
    @following = @current.followings_list
    @communities = Community.includes(%i[community_members user tags]).where(id: @user.community_member.select(:community_id))

    @friends_count = @user.matchers.size
    @community_count = @user.community_member.size
    sec = (Time.zone.now - @user.created_at).floor
    @days = (sec / 60 / 60 / 24).floor
    @comments_count = @user.comments.size
    @achievement = @user.achievement
    @report = Report.new
  end

  def edit
    @user = current_user
    permission
    @profile = current_user.profile
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    @tag = current_user.tag_list.join(',')
    @accreditation_tag = current_user.accreditation_list.join(',')
  end

  def update
    @user = current_user
    permission
    @accepted_format = %w[.jpg .jpeg .png]
    unless params['user']['images'].nil?
      unless @accepted_format.include? File.extname(params['user']['images'].original_filename)
        reject_format(params)
        return
      end
    end

    unless params['user']['header'].nil?
      unless @accepted_format.include? File.extname(params['user']['header_images'].original_filename)
        reject_format(params)
        return
      end
    end

    unless current_user.update(user_params)
      render_params(params)
      render action: 'edit'
      return
    end
    save_image(params)
    save_header(params)

    flash[:notice] = 'ユーザー情報を編集しました'
    redirect_to profile_path(current_user.userid)
  end

  def search
    redirect_to profile_path(params[:name])
  end

  def friends
    @users = User.preload(:profile, :favorite, :followers, :followings, :tags)
    @user = @users.find(current_user.id)
    @users = @user.matchers
    @pagenate = Kaminari.paginate_array(@users).page(params[:page]).per(30)
    @favorite = Favorite.all
    @name = '友達'
    render 'profiles/panel'
  end

  def follower
    @users = User.preload(:profile, :favorite, :followers, :tags)
    unless @users.exists?(userid: params[:profile_id])
      flash[:notice] = 'ユーザーが見つかりませんでした。'
      redirect_back fallback_location: pages_path
      return
    end
    @user = @users.find_by(userid: params[:profile_id])
    @users = @user.followers_list
    @pagenate = @users.page(params[:page]).per(30)
    @name = 'フォロワー'
    render 'profiles/panel'
  end

  def follow
    @users = User.preload(:profile, :favorite, :followings, :tags)
    unless @users.exists?(userid: params[:profile_id])
      flash[:notice] = 'ユーザーが見つかりませんでした。'
      redirect_back fallback_location: pages_path
      return
    end
    @user = @users.find_by(userid: params[:profile_id])
    @users = @user.followings_list
    @pagenate = @users.page(params[:page]).per(30)
    @name = 'フォロー'
    render 'profiles/panel'
  end

  def pickup
    @users = User.includes(:tags, :followings, :followers, :blocks)
    @user = @users.find(current_user.id)
    sort_pickup
    @pagenate = Kaminari.paginate_array(@users).page(params[:page]).per(30)
    @name = 'おすすめ'
    render 'profiles/panel'
  end

  private

  def user_params
    attrs = %i[nickname name userid tag_list accreditation_list]
    params.require(:user).permit(attrs, profile_attributes: %i[grade school_class number student_id accreditation hobby intro twitter_id instagram_id discord_name discord_tag])
  end

  def permission
    unless params[:id] == @user.userid
      flash[:notice] = '権限がありません'
      redirect_to profile_path
    end
  end

  def sort_pickup
    @following = @user.followings_list
    @users = @users.sort_by { |u| (@user.tags.pluck(:name) & u.tags.pluck(:name)).size }
    @users = @users.reverse
    @users &&= User.kept
    @users -= matchers(@user)
    @users -= [@user]
    @users = @users.reject { |u| u.userid.nil? }
    @users = @users.reject { |u| @user.blocks.any? { |user| user.blocked_user_id == u.id } }
    @users = @users.reject { |u| following?(@following, u) }
  end

  def reject_format(params)
    flash[:alert] = '画像は jpg jpeg png 形式のみ対応しております。'
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    @tag_list = params[:user][:tag_list]
    @accreditation_list = params[:user][:accreditation_list]
    render action: 'edit'
  end

  def save_image(params)
    if !params['user']['image'].nil? && base64?(params['user']['image']['data:image/jpeg;base64,'.length .. -1])
      filename = "#{current_user.id}#{Time.zone.now.strftime('%Y%m%d%H%M%S')}_image.jpg"
      Dir.mkdir("#{Rails.root}/tmp/users_image/") unless Dir.exist?("#{Rails.root}/tmp/users_image/")
      File.open("#{Rails.root}/tmp/users_image/#{filename}", 'wb+') do |f|
        f.write(Base64.decode64(params['user']['image']['data:image/jpeg;base64,'.length .. -1]))
      end
      f = File.open("#{Rails.root}/tmp/users_image/#{filename}")
      current_user.image.attach(io: f, filename: filename)
      f.close
      File.delete("#{Rails.root}/tmp/users_image/#{filename}")
    end
  end

  def save_header(params)
    if !params['user']['header'].nil? && base64?(params['user']['header']['data:image/jpeg;base64,'.length .. -1])
      filename = "#{current_user.id}#{Time.zone.now.strftime('%Y%m%d%H%M%S')}_header.jpg"
      Dir.mkdir("#{Rails.root}/tmp/users_header/") unless Dir.exist?("#{Rails.root}/tmp/users_header/")
      File.open("#{Rails.root}/tmp/users_header/#{filename}", 'wb+') do |f|
        f.write(Base64.decode64(params['user']['header']['data:image/jpeg;base64,'.length .. -1]))
      end
      f = File.open("#{Rails.root}/tmp/users_header/#{filename}")
      current_user.header.attach(io: f, filename: filename)
      f.close
      File.delete("#{Rails.root}/tmp/users_header/#{filename}")
    end
  end

  def render_params(params)
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    @tag_list = params[:user][:tag_list]
    @accreditation_list = params[:user][:accreditation_list]
    if base64?(params[:user][:image]['data:image/jpeg;base64,'.length .. -1])
      @image = params[:user][:image]
      @image_x = params[:user][:image_x]
      @image_y = params[:user][:image_y]
      @image_w = params[:user][:image_w]
      @image_h = params[:user][:image_h]
    end
    if base64?(params[:user][:header]['data:image/jpeg;base64,'.length .. -1])
      @header = params[:user][:header]
      @header_x = params[:user][:header_x]
      @header_y = params[:user][:header_y]
      @header_w = params[:user][:header_w]
      @header_h = params[:user][:header_h]
    end
  end
end