class ReportsController < ApplicationController

  def create
    unless report_params[:post_id]==nil
      report_template
      if @report.save
        ContactMailer.report_mail(@report).deliver
        redirect_to timelines_path, notice:"送信しました"
      else
        redirect_to timelines_path, notice: "送信に失敗しました"
      end
    end

    unless report_params[:community_id]==nil
        report_template
      if @report.save
        ContactMailer.report_mail(@report).deliver
        redirect_to communities_path, notice:"送信しました"
      else
        redirect_to communities_path, notice: "送信に失敗しました"
      end
    end

  end

  private
  def report_params
    params.require(:report).permit(:message,:reported_user_id,:post_id,:community_id,:user_id)
  end
  def report_template
    @report = Report.new(report_params)

  end
end
