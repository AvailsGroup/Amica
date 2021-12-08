class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  helper_method :following?

  def index
    @users = User.preload(:profile, :favorite, :followers, :passive_relationships, :active_relationships, :followings, :tags)
    @user = @users.find(current_user.id)
    @friends = matchers(@user)
    @following = @user.followings_list
    @follower = @user.followers_list
    @profile = @user.profile
  end

  def show
    @user = User.find_by(userid: params[:id])
    if @user.nil?
      redirect_to profiles_path, notice: "そのユーザーidは存在しませんでした"
      return
    end
    @profile = @user.profile
    @following = @user.followings_list
    @communities = Community.includes([:community_members, :user, :tags]).where(id: @user.community_member.select(:community_id))

    @friends_count = @user.matchers.size
    @community_count = @user.community_member.size
    sec = (Time.zone.now - @user.created_at).floor
    @days = (sec / 60 / 60 / 24).floor
    @comments_count = @user.comments.size
    @achievement = @user.achievement
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

    unless current_user.update(user_params)
      @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
      @tag = current_user.tag_list.join(',')
      render action: "edit"
      return
    end

    unless params["user"]["images"].nil?
      accepted_format = %w[.jpg .jpeg .png]
      unless accepted_format.include? File.extname(params["user"]["images"].original_filename)
        flash[:alert] = "画像は jpg jpeg png 形式のみ対応しております。"
        redirect_to(edit_profile_path)
        return
      end
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
    @friends = current_user.matchers
  end

  def follower
    @follower = current_user.followers_list
  end

  def follow
    @following = current_user.followings_list
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
end