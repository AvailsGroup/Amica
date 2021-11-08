class MypagesController < ApplicationController
  before_action :sign_in_required, only: [:show]
  def index
    @profiles = current_user
  end

  @user = current_user
  user = @user

  redirect_to mypages_path
end
