class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  require 'active_support/all'

  def index
    @user = current_user
    @friends = current_user.matchers
    @following = current_user.followings_list
    @follower = current_user.followers_list
    @users = User.all
    @profile = Profile.find(current_user.id)
  end

  def show
    @user = current_user
    if params[:id] == @user.userid
      @achievement = Achievement.find_by(userid: current_user.id)
      if @achievement.nil?
        @achievement = Achievement.new
        @achievement.userid = current_user.id
        @achievement.save
      end
      @achievement = Achievement.find_by(userid: current_user.id)
      days = Date.today - current_user.created_at.to_date + 1
      @achievement.update(
        communitiesCount: Community.where(user_id: current_user.id).count,
        registrationDays: days.numerator,
        friendsCount: current_user.matchers.count,
        likesCount: Like.where(user_id: current_user.id).count,
        postsCount: Post.where(userid: current_user.id).count,
        commentsCount:Comment.where(user_id: current_user.id).count
      )
      @badge = true
    else
      @user = User.find_by(userid: params[:id])
      @achievement = Achievement.find_by(userid: @user.id)
      if @achievement.nil?
        @badge = false
      else
        @badge = true
      end

    end

    @profiles = Profile.find(current_user.id)
    @user = User.find_by(userid: params[:id])
    if @user.nil?
      redirect_to profiles_path, notice: "そのユーザーidは存在しませんでした"
      return
    end
    @profile = Profile.find(@user.id)
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

    unless  current_user.update(user_params)
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

  def badge?
    @achievement.postsCount >= 100 ? @posts_badge1 = true : false
    @achievement.postsCount >= 1000 ? @posts_badge2 = true : false
    @achievement.postsCount >= 10000 ? @posts_badge3 = true : false
  end

end