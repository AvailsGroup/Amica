class MypagesController < ApplicationController
  def index
    @user = current_user
  end

  def update
    @user = current_user
    user = @user

    if user.valid_password?(params[:password])
        if params[:image]
          @user.update(image:"#{@user.id}.jpg")
          image = params[:image]
          File.binwrite("public/user_images/#{@user.image}", image.read)
          flash[:notice] = "ユーザー情報を編集しました"
          redirect_to mypages_path
        end
    else
      flash[:notice] = "PASSWORD ERROR"
      redirect_to mypages_path
    end
  end

end
