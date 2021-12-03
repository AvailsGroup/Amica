class MypagesController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def edit
    @user = current_user
    permission
    @profile = Profile.find(current_user.id)
  end

  def update
    current_user.update(user_params)
    if params["user"]["image"]
      current_user.update(image: "#{current_user.id}.jpg")
      File.open("public/user_images/#{current_user.image}", 'wb') do |f|
        f.write(Base64.decode64(params["user"]["image"]['data:image/png;base64,'.length .. -1]))
      end
    end
    flash[:notice] = "ユーザー情報を編集しました"
    redirect_to profile_path
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
end
