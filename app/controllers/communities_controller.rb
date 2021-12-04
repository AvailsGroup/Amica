class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @community = Community.all.order(created_at: :desc)
    @user = User.all
    @member = CommunityMember.all
    @join = CommunityMember.where(user_id: current_user.id).count
  end

  def new
    @community = Community.new
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
  end

  def create
    @community = Community.new(community_params)
    @community.user_id = current_user.id

    unless @community.save
      @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
      render action: "new"
      return
    end

    if community_params[:icon]
      image = community_params[:icon]
      File.binwrite("public/communities_image/#{@community.id}.jpg", image.read)
      @community.update(icon:"#{@community.id}.jpg")
    end

    flash[:notice] = "コミュニティを作成しました！"
    CommunityMember.create(user_id: current_user.id, community_id: @community.id)
    redirect_to(communities_path)
  end

  def show
    @community = Community.find(params[:id])
    @join = CommunityMember.exists?(user: current_user, community_id: @community.id)
    @members = CommunityMember.where(community_id: @community.id)
    @user = User.all
    @tag = @community.tag_counts_on(:tags)
    @leader = @community.user_id ==current_user.id
  end

  def edit
    @community = Community.find(params[:id])
    permission
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    @tag = @community.tag_list.join(',')
  end

  def update
    @community = Community.find(params[:id])
    permission
    unless  @community.update(community_params)
      @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
      @tag = @community.tag_list.join(',')
      render action: "edit"
      return
    end
    if community_params[:icon]
      image = community_params[:icon]
      File.binwrite("public/communities_image/#{@community.id}.jpg", image.read)
      @community.update(icon:"#{@community.id}.jpg")
    end
    flash[:notice] = "コミュニティを編集しました！"
    redirect_to(community_path(@community.id))
  end
  
  def destroy
    @community = Community.find(params[:id])
    permission
    @community.destroy
    flash[:notice] = "コミュニティを削除しました！"
    redirect_to(communities_path)
  end

  #Async
  def pickup

  end

  #Async
  def joined
    @community = []
    join = CommunityMember.where(user_id: current_user.id).order(created_at: :desc)
    join.each do |m|
      @community.push(Community.find(m.community_id))
    end
    @user = User.all
    @member = CommunityMember.all
  end

  private

  def community_params
    params.require(:community).permit(:name, :content, :icon, :tag_list)
  end

  def permission
    unless @community.user_id == current_user.id
      flash[:notice] = "コミュニティを編集できるのはリーダーのみです"
      redirect_to(community_path)
    end
  end
end
