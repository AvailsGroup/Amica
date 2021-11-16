class CommunitiesController < ApplicationController
  def index
    @community = Community.all
    @user = User.all
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    @community.user_id = current_user.id
    @community.save
    pp @community.id
    pp community_params[:icon]
    if  community_params[:icon]
      image = community_params[:icon]
      File.binwrite("public/communities_image/#{@community.id}.jpg", image.read)
    end
    @community.icon = "#{@community.id}.jpg"

    if @community.save
      redirect_to(communities_path)
    else
      redirect_to(about_path)
    end
  end

  def show
    @community = Community.find(params[:id])
  end

  private
  def community_params
    params.require(:community).permit(:name,:content,:icon)
  end
end
