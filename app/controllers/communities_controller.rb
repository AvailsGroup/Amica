class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  before_action :set_community_tags_to_gon, only: [:new]

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

    if community_params[:icon]
      image = community_params[:icon]
      File.binwrite("public/communities_image/#{@community.id}.jpg", image.read)
      @community.icon = "#{@community.id}.jpg"
    end

    flash[:notice] = @community.save ? "コミュニティを作成しました！" : "不明なエラーが発生しました。"
    redirect_to(communities_path)
  end

  def show
    @community = Community.find(params[:id])
  end

  def set_available_tags_to_gon
    gon.available_tags = Community.tags_on(:tags).pluck(:name)
  end

  private

  def set_community_tags_to_gon
    gon.community_tags = @community.tag_list
  end

  def community_params
    params.require(:community).permit(:name, :content, :icon, :tag_list)
  end
end
