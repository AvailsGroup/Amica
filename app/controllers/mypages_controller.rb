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


    redirect_to profile_path
  end

  def show
    @user = current_user

  end


  private


  def user_params
    attrs = [
      :nickname,:name,:image
    ]

    params.require(:user).permit(attrs, profile_attributes:%i[grade school_class number student_id accreditation hobby])
    end

end
