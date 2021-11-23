class PagesController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index
    @mates = current_user.matchers
  end

  def show

  end
end
