class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
    @friends = current_user.matchers
    @following = current_user.followings_list
    @follower = current_user.followers_list
    @users = User.all
    @profile = Profile.find(current_user.id)
  end

  def show
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
  end

  def update
    current_user.update(user_params)
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
    redirect_to profile_path
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
    attrs = [:nickname,:name]
    params.require(:user).permit(attrs, profile_attributes:%i[grade school_class number student_id accreditation hobby])
  end

  def permission
    unless params[:id] == @user.userid
      flash[:notice] = "権限がありません"
      redirect_to profile_path
    end
  end

  def base64?(value)
    value.is_a?(String) && Base64.strict_encode64(Base64.decode64(value)) == value
  end
end