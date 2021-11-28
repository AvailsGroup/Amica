class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

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

    pp params["item"]["tags"]
    if community_params[:icon]
      image = community_params[:icon]
      File.binwrite("public/communities_image/#{@community.id}.jpg", image.read)
      @community.icon = "#{@community.id}.jpg"
    end

    flash[:notice] = if @community.save
      "コミュニティを作成しました！"
    else
      "不明なエラーが発生しました。"
                     end
    redirect_to(communities_path)
  end

  def show
    @community = Community.find(params[:id])
  end

  private

  def community_params
    params.require(:community).permit(:name,:content,:icon)
  end
end
