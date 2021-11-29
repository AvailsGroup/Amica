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
    session[:crop_x] = user_params[:x]
    session[:crop_y] = user_params[:y]
    session[:crop_width] = user_params[:width]
    session[:crop_height] = user_params[:height]


    if params[:image]
      current_user.update(image:"#{current_user.id}.jpg")
      image = params[:image]
      File.binwrite("public/user_images/#{current_user.image}", image.read)
      Rails.cache.delete("image")
    end
    flash[:notice] = "ユーザー情報を編集しました"
    redirect_to(profile_path)
  end

  def show
    @user = current_user

  end


  private

  def user_params
    params.require(:user).permit(:nickname,:name,:image,:image_x,:image_y,:image_w,:image_h,:aspect_numerator,
                                 :aspect_denominator,
                                 profile_attributes:%i[grade school_class number student_id accreditation hobby])
  end

end
