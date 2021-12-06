class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def tag
    @users = User.tagged_with(params[:search_id])
    @communities = Community.tagged_with(params[:search_id])
  end

  def user
    # ^_^
  end

  def community
    # @_@
  end
end
