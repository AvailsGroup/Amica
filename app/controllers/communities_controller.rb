class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @community = Community.includes([:community_members, :user, :tags]).order(created_at: :desc)
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
    @community = Community.includes(:user, :tags,:community_members).find(params[:id])
    @join = @community.community_members.exists?(user: current_user)
    @leader = @community.user
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

    unless  @community.update(user_params)
      @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
      @tag = @community.tag_list.join(',')
      render action: "edit"
      return
    end

    unless params["community"]["images"].nil?
      accepted_format = %w[.jpg .jpeg .png]
      unless accepted_format.include? File.extname(params["community"]["images"].original_filename)
        flash[:alert] = "画像は jpg jpeg png 形式のみ対応しております。"
        redirect_to(edit_profile_path)
        return
      end
    end

    if !params["community"]["images"].nil? && base64?(params["community"]["image"]['data:image/jpeg;base64,'.length .. -1])
      unless @community.image.nil?
        if File.exist?("public/user_images/#{@community.image}")
          File.delete("public/user_images/#{@community.image}")
        end
      end
      rand = rand(1_000_000..9_999_999)
      @community.update(image: "#{@community.id}#{rand}.jpg")
      File.open("public/user_images/#{@community.image}", 'wb') do |f|
        f.write(Base64.decode64(params["community"]["image"]['data:image/jpeg;base64,'.length .. -1]))
      end
    end
    flash[:notice] = "ユーザー情報を編集しました"
    redirect_to profile_path
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
    @community = Community.includes([:community_members, :user, :tags]).where(id: current_user.community_member.select(:community_id)).order(created_at: :desc)
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
