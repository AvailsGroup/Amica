class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @community = Community.includes([:community_members, :user, :tags]).order(created_at: :desc).page(params[:page]).per(24)
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
      render action: "timelines/new"
      return
    end

    unless params["community"]["images"].nil?
      accepted_format = %w[.jpg .jpeg .png]
      unless accepted_format.include? File.extname(params["community"]["images"].original_filename)
        flash[:alert] = "画像は jpg jpeg png 形式のみ対応しております。"
        redirect_to(new_community_path)
        return
      end
    end

    if !params["community"]["images"].nil? && base64?(params["community"]["icon"]['data:image/jpeg;base64,'.length .. -1])
      unless @community.image.nil?
        if File.exist?("public/communities_image/#{@community.icon}")
          File.delete("public/communities_image/#{@community.icon}")
        end
      end
      rand = rand(1_000_000..9_999_999)
      @community.update(icon: "#{@community.id}#{rand}.jpg")
      File.open("public/communities_image/#{@community.icon}", 'wb') do |f|
        f.write(Base64.decode64(params["community"]["icon"]['data:image/jpeg;base64,'.length .. -1]))
      end
    end

    flash[:notice] = "コミュニティを作成しました！"
    CommunityMember.create(user_id: current_user.id, community_id: @community.id)
    redirect_to(communities_path)
  end

  def show
    @community = Community.includes(:user, :tags,:community_members).find(params[:id])
    @join = @community.community_members.exists?(user: current_user)
    @leader = @community.user
    @report = Report.new
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

    unless @community.update(community_params)
      @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
      @tag = @community.tag_list.join(',')
      render action: "edit"
      return
    end

    unless params["community"]["images"].nil?
      accepted_format = %w[.jpg .jpeg .png]
      unless accepted_format.include? File.extname(params["community"]["images"].original_filename)
        flash[:alert] = "画像は jpg jpeg png 形式のみ対応しております。"
        redirect_to(edit_community_path)
        return
      end
    end

    if !params["community"]["images"].nil? && base64?(params["community"]["image"]['data:image/jpeg;base64,'.length .. -1])
      unless @community.image.nil?
        if File.exist?("public/communities_image/#{@community.icon}")
          File.delete("public/communities_image/#{@community.icon}")
        end
      end
      rand = rand(1_000_000..9_999_999)
      @community.update(icon: "#{@community.id}#{rand}.jpg")
      File.open("public/communities_image/#{@community.icon}", 'wb') do |f|
        f.write(Base64.decode64(params["community"]["image"]['data:image/jpeg;base64,'.length .. -1]))
      end
    end
    flash[:notice] = "ユーザー情報を編集しました"
    redirect_to community_path(@community.id)
  end
  
  def destroy
    @community = Community.find(params[:id])
    permission
    @community.destroy
    flash[:notice] = "コミュニティを削除しました！"
    redirect_to(communities_path)
  end

  # Async
  def pickup

  end

  # Async
  def joined
    @community = Community.includes([:community_members, :user, :tags]).where(id: current_user.community_member.select(:community_id)).order(created_at: :desc)
  end

  def members
    @community = Community.includes([:community_members, :user, :tags]).find(params[:community_id])
    @count = @community.community_members.size
    @member = @community.community_members.page(params[:page]).per(2)
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
