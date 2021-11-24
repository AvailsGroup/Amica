class PagesController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index
    @user = current_user
  end

  def show
    @user = current_user
  end

end
