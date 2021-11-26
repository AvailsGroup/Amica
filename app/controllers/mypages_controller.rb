class MypagesController < ApplicationController
  before_action :sign_in_required, only: [:show]


  def index
    @user = current_user
    @profiles = Profile.find(current_user.id)

  end

  def edit
    @user = current_user
    @profile = Profile.find(current_user.id)

  end

  def update
    Profile.update(profile_params)
    if params[:image]
      current_user.update(image:"#{current_user.id}.jpg")
      image = params[:image]
      File.binwrite("public/user_images/#{current_user.image}", image.read)
      Rails.cache.delete("image")
      flash[:notice] = "ユーザー情報を編集しました"
    end
    redirect_to(mypages_path)
  end

  def show
    @user = current_user
  end

  def update_nickname
    @users = current_user.update(nickname: params[:nickname])
    redirect_to(mypages_path)
  end

  def update_name
    @users = current_user.update(name: params[:name])
    redirect_to(mypages_path)
  end

  private
  def profile_params
    params.require(:profile).permit(:grade,:school_class,:number,:student_id,:accreditation,:hobby)
  end



end
