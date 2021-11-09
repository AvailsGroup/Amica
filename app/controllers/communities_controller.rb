class CommunitiesController < ApplicationController
  def index
    @community = Community.all
  end
  def new
    @community = Community.new
  end
  def create
    @community = Community.new(community_params)
    if @community.save
    redirect_to(communities_path)
    else
      redirect_to(about_path)
    end
  end
  private
  def community_params
    params.require(:community).permit(:name,:content)
  end
end
