class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  helper_method :following?
  helper_method :matchers?
  helper_method :is_user_favorite?

  def index
    @users = User.includes(:profile, :favorite, :followers, :passive_relationships, :active_relationships, :followings, :tags).where.not(userid: nil)
    @user = @users.find(current_user.id)
    @friends = matchers(@user)
    @following = @user.followings_list
    @follower = @user.followers_list
    @profile = @user.profile
    sort_pickup
    @users -= @friends
    @users -= [@user]
  end

  def show
    @users = User.includes(:profile, :favorite, :followers, :passive_relationships, :active_relationships, :followings, :posts, :tags)
    @user = @users.find_by(userid: params[:id])
    @current = @users.find(current_user.id)
    if @user.nil?
      redirect_to profiles_path, notice: "そのユーザーidは存在しませんでした"
      return
    end
    @profile = @user.profile
    @following = @current.followings_list
    @communities = Community.includes([:community_members, :user, :tags]).where(id: @user.community_member.select(:community_id))

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
    @profile = Profile.find(current_user.id)
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    @tag = current_user.tag_list.join(',')
    @accreditation_tag = current_user.accreditation_list.join(',')
  end

  def update
    @user = current_user
    permission

    unless params["user"]["images"].nil?
      accepted_format = %w[.jpg .jpeg .png]
      unless accepted_format.include? File.extname(params["user"]["images"].original_filename)
        flash[:alert] = "画像は jpg jpeg png 形式のみ対応しております。"
        redirect_to(edit_profile_path)
        return
      end
    end

    unless current_user.update(user_params)
      @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
      @tag = current_user.tag_list.join(',')
      render action: "edit"
      return
    end

    if !params["user"]["images"].nil? && base64?(params["user"]["image"]['data:image/jpeg;base64,'.length .. -1])
      unless current_user.image.nil?
        if File.exist?("public/user_images/#{current_user.image}")
          File.delete("public/user_images/#{current_user.image}")
        end
      end
      rand = rand(1_000_000..9_999_999)
      current_user.update(image: "#{current_user.id}#{rand}.jpg")
      File.open("public/user_images/#{current_user.image}", 'wb') do |f|
        f.write(Base64.decode64(params["user"]["image"]['data:image/jpeg;base64,'.length .. -1]))
      end
    end
    flash[:notice] = "ユーザー情報を編集しました"
    redirect_to profile_path(current_user.userid)
  end

  def search
    redirect_to profile_path(params[:name])
  end

  def friends
    @users = User.preload(:profile, :favorite, :followers, :followings, :tags)
    @user = @users.find(current_user.id)
    @friends = @user.matchers
    @pagenate = Kaminari.paginate_array(@friends).page(params[:page]).per(30)
    @favorite = Favorite.all
  end

  def follower
    @users = User.preload(:profile, :favorite, :followers, :tags)
    @user = @users.find(current_user.id)
    @follower = @user.followers_list
    @pagenate = @follower.page(params[:page]).per(30)
  end

  def follow
    @users = User.preload(:profile, :favorite,  :followings, :tags)
    @user = @users.find(current_user.id)
    @following = @user.followings_list
    @pagenate =  @following.page(params[:page]).per(30)
  end

  def pickup
    @users = User.includes(:tags,:followings,:followers).where.not(userid: nil)
    @user = @users.find(current_user.id)
    @users -= matchers(@user)
    @users -= [@user]
    sort_pickup
    @pagenate = Kaminari.paginate_array(@users).page(params[:page]).per(30)
  end

  private

  def user_params
    attrs = [:nickname,:name,:userid,:tag_list,:accreditation_list]
    params.require(:user).permit(attrs, profile_attributes:%i[grade school_class number student_id accreditation hobby])
  end

  def permission
    unless params[:id] == @user.userid
      flash[:notice] = "権限がありません"
      redirect_to profile_path
    end
  end

  def sort_pickup
    @users = @users.sort_by { |u| (@user.tags.pluck(:name) & u.tags.pluck(:name)).size }
    @users = @users.reverse
  end
end