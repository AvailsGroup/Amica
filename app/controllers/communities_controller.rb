class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @community = Community.all
    @user = User.all
  end

  def new
    @community = Community.new
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
  end

  def create
    @community = Community.new(community_params)
    @community.user_id = current_user.id

    if community_params[:icon]
      image = community_params[:icon]
      File.binwrite("public/communities_image/#{Community.count + 1}.jpg", image.read)
      @community.icon = "#{Community.count + 1}.jpg"
    end

    if @community.save
      redirect_to(communities_path)
    else
      @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
      render action: "new"
    end


  end

  def show
    @community = Community.find(params[:id])
    @tag = @community.tag_counts_on(:tags)
  end

  private

  def community_params
    params.require(:community).permit(:name, :content, :icon, :tag_list)
  end
end
