class ReportsController < ApplicationController

  def create
    @report = Report.new(report_params)
    if @report.save
      ContactMailer.report_mail(@report).deliver
      redirect_to timelines_path, notice:"送信しました"
    else
      redirect_to timelines_path, notice: "送信に失敗しました"
    end
  end

  private
  def report_params
    params.require(:report).permit(:message,:reported_user_id,:post_id,:user_id)
  end
end
