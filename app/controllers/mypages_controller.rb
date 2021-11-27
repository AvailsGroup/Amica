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

  def new
    @profile = Profile.new
    @user = User.new
  end

  def update
    current_user.update(user_params)

    if params[:image]
      current_user.update(image:"#{current_user.id}.jpg")
      image = params[:image]
      File.binwrite("public/user_images/#{current_user.image}", image.read)
      Rails.cache.delete("image")
    end
    flash[:notice] = "ユーザー情報を編集しました"
    redirect_to(mypages_path)
  end

  def show
    @user = current_user
  end


  private

  def user_params
    params.require(:user).permit(:nickname,:name, profile_attributes:
      %i[grade school_class number student_id accreditation hobby])
  end

end
