class MypagesController < ApplicationController
  before_action :sign_in_required, only: [:show]
  def index
    @profiles = Profile.find(current_user.id)
  end

  def edit
    @profile = Profile.find(current_user.id)
  end

  def update
    Profile.update(profile_params)
    redirect_to(mypages_path)
  end

  private
  def profile_params
    params.require(:profile).permit(:grade,:school_class,:number,:student_id,:accreditation,:hobby)
  end
end
