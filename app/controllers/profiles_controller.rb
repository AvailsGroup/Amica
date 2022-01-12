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
    @following = @user.followings_list
    @follower = @user.followers_list
    @profile = @user.profile
    sort_pickup
    @users &&= User.kept
    @users -= @friends
    @users -= [@user]
    @users = @users.reject { |u| u.userid.nil? }
    @users = @users.reject { |u| @user.blocks.any? { |user| user.blocked_user_id == u.id } }
    @users = @users.reject { |u| following?(@following, u) }
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

    unless params['user']['images'].nil?
      accepted_format = %w[.jpg .jpeg .png]
      unless accepted_format.include? File.extname(params['user']['images'].original_filename)
        flash[:alert] = '画像は jpg jpeg png 形式のみ対応しております。'
        @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
        @tag_list = params[:user][:tag_list]
        @accreditation_list = params[:user][:accreditation_list]
        render action: 'edit'
        return
      end
    end

    unless current_user.update(user_params)
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
      render action: 'edit'
      return
    end

    if !params['user']['image'].nil? && base64?(params['user']['image']['data:image/jpeg;base64,'.length .. -1])
      filename = "#{current_user.id}#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.jpg"
      Dir.mkdir("#{Rails.root}/tmp/users_image/") unless Dir.exist?("#{Rails.root}/tmp/users_image/")
      File.open("#{Rails.root}/tmp/users_image/#{filename}", 'wb+') do |f|
        f.write(Base64.decode64(params['user']['image']['data:image/jpeg;base64,'.length .. -1]))
      end
      f = File.open("#{Rails.root}/tmp/users_image/#{filename}")
      current_user.image.attach(io: f, filename: filename)
      f.close
      File.delete("#{Rails.root}/tmp/users_image/#{filename}")
    end
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
    @users &&= User.kept
    @users -= matchers(@user)
    @users -= [@user]
    @users = @users.reject { |u| u.userid.nil? }
    @users = @users.reject { |u| @user.blocks.any? { |user| user.blocked_user_id == u.id } }
    @users = @users.reject { |u| following?(@following, u) }

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
    @users = @users.sort_by { |u| (@user.tags.pluck(:name) & u.tags.pluck(:name)).size }
    @users = @users.reverse
  end
end