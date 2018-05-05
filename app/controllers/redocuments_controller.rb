class RedocumentsController < ApplicationController
  before_action :require_login
  def download
    @report = Report.find(params[:report_id])
    send_file "#{Rails.root}/public#{@report.document.file_url}"
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
