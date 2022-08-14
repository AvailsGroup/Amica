class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :login_limit
  before_action :banned

  def create
    @users = User.all
    @posts = Post.all
    @communities = Community.all
    @comments = Comment.all

    if Report.exists?(user: current_user,
                      post: params[:report][:post_id].nil? ? nil : @posts.find(params[:report][:post_id]),
                      community: params[:report][:community_id].nil? ? nil : @communities.find(params[:report][:community_id]),
                      comment: params[:report][:comment_id].nil? ? nil : @comments.find(params[:report][:comment_id]))
      redirect_back fallback_location: pages_path, notice: 'すでに送信しています'
      return
    end

    @report = Report.new
    @report.user = current_user
    @report.message = params[:report][:message]
    @report.post = params[:report][:post_id].nil? ? nil : @posts.find(params[:report][:post_id])
    @report.community = params[:report][:community_id].nil? ? nil : @communities.find(params[:report][:community_id])
    @report.comment = params[:report][:comment_id].nil? ? nil : @comments.find(params[:report][:comment_id])

    if params[:report][:post_id].nil? && params[:report][:community_id].nil?
      return unless Comment.exists?(id: params[:report][:comment_id])
      comment = Comment.find(params[:report][:comment_id])
      @report.reported_user = comment.user
    end

    if params[:report][:comment_id].nil? && params[:report][:community_id].nil?
      return unless Post.exists?(id: params[:report][:post_id])
      post = Post.find(params[:report][:post_id])
      @report.reported_user = post.user
    end

    @report.save

    ContactMailer.report_mail(@report).deliver

    redirect_back fallback_location: timelines_path, notice: '送信しました' unless @report.post.nil?
    redirect_back fallback_location: communities_path, notice: '送信しました' unless @report.community.nil?
    redirect_back fallback_location: timeline_path(@comments.find(params[:report][:comment_id]).post_id), notice: '送信しました' unless @report.comment.nil?
  end

  private

  def report_params
    params.require(:report).permit(:message, :reported_user_id, :post_id, :community_id, :comment_id, :user_id)
  end
end
