class ReportsController < ApplicationController
  def new
    @report = Report.new
    render layout: 'home'
    flash.now[:notice] = 'test'
  end

  def create
    @report_content = Report.new(report_params)
    @report_content.user_id = current_user.id
    if @report_content.save
      ContactMailer.report_mail(@report_content).deliver
      redirect_to "/reports/new", notice:"送信しました"
    else
      render :new
    end
  end

  private
  def report_params
    params.require(:report).permit(:message)
  end
end
