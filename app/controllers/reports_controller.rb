class ReportsController < ApplicationController

  def create
    @users = User.all
    @posts = Post.all
    @communities = Community.all
    @comments = Comment.all
    @report = Report.new
    @post_id = @comments.find(params[:report][:comment_id]).post_id

    @report.user = current_user
    @report.message = params[:report][:message]
    @report.reported_user = params[:report][:reported_user_id].nil? ? nil : @users.find(params[:report][:reported_user_id])
    @report.post = params[:report][:post_id].nil? ? nil : @posts.find(params[:report][:post_id])
    @report.community = params[:report][:community_id].nil? ? nil : @communities.find(params[:report][:community_id])
    @report.comment = params[:report][:comment_id].nil? ? nil : @comments.find(params[:report][:comment_id])
    @report.save
    ContactMailer.report_mail(@report).deliver

    unless @report.post == nil
      redirect_to timelines_path, notice: "送信しました"
    end
    unless @report.community == nil
      redirect_to communities_path, notice: "送信しました"
    end
    unless @report.comment == nil
      redirect_to timeline_path(@post_id), notice: "送信しました"
    end
  end

  private

  def report_params
    params.require(:report).permit(:message, :reported_user_id, :post_id, :community_id, :comment_id, :user_id)
  end
end
