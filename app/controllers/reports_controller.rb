class ReportsController < ApplicationController

  def create
    @users = User.all
    @posts = Post.all
    @communities = Community.all
    @report = Report.new

    @report.user = current_user
    @report.message = params[:report][:message]
    @report.reported_user = params[:report][:reported_user_id].nil? ? nil : @users.find(params[:report][:reported_user_id])
    @report.post = params[:report][:post_id].nil? ? nil : @posts.find(params[:report][:post_id])
    @report.community = params[:report][:community_id].nil? ? nil : @communities.find(params[:report][:community_id])

    @report.save
    ContactMailer.report_mail(@report).deliver
    redirect_to timelines_path, notice: "送信しました"
  end

  private

  def report_params
    params.require(:report).permit(:message, :reported_user_id, :post_id, :community_id, :user_id)
  end
end
