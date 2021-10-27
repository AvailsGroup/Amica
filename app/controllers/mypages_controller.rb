class MypagesController < ApplicationController
  def index
    @user = current_user
  end

  def update
    @user = current_user

    if params[:image]
      #@user.image = "#{@user.id}.jpg"
      @user.update(image:"#{@user.id}.jpg")
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image}", image.read)
      flash.now[:notice] = "ユーザー情報を編集しました"
      #redirect_to mypages_path
    else
      flash.now[:notice] = "ERROR"
      #redirect_to mypages_path
    end
  end


    def check
      @user = current_user
      if @user.valid_password?(params[:password])
        redirect_to mypages_update_path
      else
        flash.now[:notice] = "PASSWORD ERROR"
        redirect_to mypages_path
      end
    end

  helper_method :check
end
