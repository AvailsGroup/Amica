class MypagesController < ApplicationController
  def index
    @user = User.new
    ImageUploader
  end

  def create
    @user = User.find_by(id: params[:id])

    if params[:image]
      @user.image = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("/app/assets/user_images/#{@user.image}", image.read)
      flash[:success] = "画像を登録しました。"
      render 'mypages/index'
    end

  end

  def update
    @user = User.find_by(id: params[:id])
    @user.id = params[:id]

    if params[:image]
      @user.image = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("/user_images/#{@user.image}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("mypages/index")
    end
  end

  def new

  end

  def show

  end

end
