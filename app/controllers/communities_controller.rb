class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  helper_method :community_ban?
  helper_method :is_community_favorite?

  def index
    view_parameter
    @community = @community.order(created_at: :desc).page(params[:page]).per(36)
    redirect('index')
  end

  def pickup
    view_parameter
    @community = @community.order(created_at: :desc).where.not(id: current_user.community_member.select(:community_id))
    @community = @community.sort_by { |u| (@user.tags.pluck(:name) & u.tags.pluck(:name)).size }
    @community = @community.reverse
    @community = Kaminari.paginate_array(@community).page(params[:page]).per(36)
    redirect('pickup')
  end

  def joined
    view_parameter
    @community = @community.where(id: current_user.community_member.select(:community_id)).order(created_at: :desc).page(params[:page]).per(36)
    redirect('joined')
  end

  def show
    @community = Community.includes(:user, :tags, :community_members, :community_securities,:favorites ).find(params[:id])
    @users = User.includes(:community_member, :tags)
    @user = @users.find(current_user.id)
    @join = @community.community_members.any? { |c| c.user_id == @user.id }
    @leader = @community.user
    @favorite = Favorite.all
    @report = Report.new
    exists_community_security
  end

  def new
    @community = Community.new
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
  end

  def create
    @community = Community.new(community_params)
    @community.user_id = current_user.id

    check_format(new_community_path)

    unless @community.save
      @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
      render 'communities/new'
      return
    end

    check_image

    flash[:notice] = 'コミュニティを作成しました！'
    CommunityMember.create(user_id: current_user.id, community_id: @community.id)
    redirect_to(communities_path)
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
    check_format(edit_community_path)
    unless @community.update(community_params)
      @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
      @tag = @community.tag_list.join(',')
      render action: 'edit'
      return
    end
    check_image
    flash[:notice] = 'ユーザー情報を編集しました'
    redirect_to community_path(@community.id)
  end

  def destroy
    @community = Community.find(params[:id])
    permission
    @community.destroy
    flash[:notice] = 'コミュニティを削除しました！'
    redirect_to(communities_path)
  end

  def members
    @community = Community.includes(:community_members, :tags, :user,:favorites, :community_securities).find(params[:community_id])
    @count = @community.community_members.size
    @member = @community.community_members.includes([:user]).page(params[:page]).per(30)
    @users = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @user = @users.find(current_user.id)
    @page = 'member'
  end

  def banned_member
    @community = Community.includes(:community_members, :tags, :user,:favorites, :community_securities).find(params[:community_id])
    permission
    @count = @community.community_securities.size
    @member = @community.community_securities.includes([:user]).page(params[:page]).per(30)
    @users = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @user = @users.find(current_user.id)
    @page = 'banned'
    render 'communities/members'
  end

  def kick
    @community = Community.includes(:community_members, :tags, :user,:favorites, :community_securities).find(params[:community_id])
    permission
    @users = User.includes(:community_member, :tags)
    @user = @users.find(params[:id])
    if @community.community_members.any? { |m| m.user_id == @user.id }
      @cm = CommunityMember.find_by(user_id: @user.id, community_id: @community.id)
      @cm.destroy
      if Favorite.exists?(user_id: @user.id, community_id: @community.id)
        Favorite.find_by(user_id: @user.id, community_id: @community.id).destroy
      end
    end
    flash[:notice] = 'ユーザーを強制退出させました。'
    redirect_to(community_members_path(@community.id))
  end

  def change
    @community = Community.find(params[:community_id])
    permission
    @users = User.includes(:community_member ,:tags)
    @user = @users.find(params[:id])
    @community.update_attribute(:user_id, @user.id)
    flash[:notice] = "#{@user.name}にリーダー権限を譲渡しました。"
    redirect_to(community_members_path)
  end

  private

  def community_ban?(community)
    community.community_securities.any? { |c| c.user_id == @user.id }
  end

  def view_parameter
    @users = User.includes(:community_member, :tags)
    @user = @users.find(current_user.id)
    @community = Community.includes(:community_members, :tags, :user, :favorites, :community_securities)
  end

  def community_params
    params.require(:community).permit(:name, :content, :tag_list)
  end

  def permission
    unless @community.user_id == current_user.id
      flash[:notice] = '権限がありません。'
      redirect_to(communities_path)
    end
  end

  def exists_community_security
    if CommunitySecurity.exists?(community_id:@community.id, user_id:@user.id)
      flash[:alert] = 'あなたはこのコミュニティから参加禁止にされています。'
      redirect_to communities_path
    end
  end

  def redirect(page)
    @page = page
    render 'communities/index'
  end

  def check_format(path)
    unless params['community']['images'].nil?
      accepted_format = %w[.jpg .jpeg .png]
      unless accepted_format.include? File.extname(params['community']['images'].original_filename)
        flash[:alert] = '画像は jpg jpeg png 形式のみ対応しております。'
        redirect_to(path)
      end
    end
  end

  def check_image
    if !params['community']['images'].nil? && base64?(params['community']['image']['data:image/jpeg;base64,'.length .. -1])
      save_image
    end
  end

  def save_image
    filename = "#{@community.id}#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.jpg"
    Dir.mkdir("#{Rails.root}/tmp/communities_image/") unless Dir.exist?("#{Rails.root}/tmp/communities_image/")
    File.open("#{Rails.root}/tmp/communities_image/#{filename}", 'wb+') do |f|
      f.write(Base64.decode64(params['community']['image']['data:image/jpeg;base64,'.length .. -1]))
    end
    f = File.open("#{Rails.root}/tmp/communities_image/#{filename}")
    @community.image.attach(io: f, filename: filename)
    f.close
    File.delete("#{Rails.root}/tmp/communities_image/#{filename}")
  end
end
