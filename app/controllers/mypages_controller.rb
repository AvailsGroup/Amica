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
      Profile.update(image:"#{current_user.id}.jpg")
      image = params[:image]
      File.binwrite("public/user_images/#{current_user.image}", image.read)
      flash[:notice] = "ユーザー情報を編集しました"
    end
    redirect_to(mypages_path)
  end

  private
  def profile_params
    params.require(:profile).permit(:grade,:school_class,:number,:student_id,:accreditation,:hobby)
  end

  def create
    @user = current_user
    user = @user

        if params[:image]
          @user.update(image:"#{@user.id}.jpg")
          image = params[:image]
          File.binwrite("public/user_images/#{@user.image}", image.read)
          flash[:notice] = "ユーザー情報を編集しました"
          redirect_to mypages_path
        end

  end

end
