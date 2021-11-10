class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_report, only: [:refresh_onedrive_file, :save_pivottable, :delete_pivottable, :share_report, :show, :edit, :update, :destroy]
  before_action :authorize, except: [:index]
  before_action :set_repot_document, only: :create
  before_action :change_positions, only: :show
  before_action :check_one_drive_data, only: :refresh_onedrive_file
  include ReportsHelper
  # GET /reports/1
  # GET /reports/1.json
  def show
    @query_id         = params[:query_id] rescue nil
    @pivot_tables     = @report.save_pivot_tables
    @report_dashboard = @report.dashboards
    render_403 unless  @channel.is_public? or @channel.is_creator? or @channel.my_permission.can_view_report?
  end

  # GET /reports/new
  def new
    @report = Report.new(user_id: User.current.id, channel_id: @channel.id)
  end

  # GET /reports/1/edit
  def edit
  end

  def refresh_onedrive_file
    begin
      data = OneDriveRefreshService.new(current_user, @report.report_documents.first).call
      data[:type] == 'notice' ? flash[:notice] = data[:message] : flash[:alert] = data[:message]
      if data[:url].present?
        session[:data] = {c_id: @channel.id, r_id: @report.id}
        redirect_to data[:url]
      else
        redirect_to channel_report_path(@channel, @report)
      end
    rescue StandardError => e
      flash[:alert] = e.message
      redirect_to channel_report_path(@channel, @report)
    end
  end

  def upload_document
    if request.post?
      set_report if params[:id].present?
      respond_to do |format|
        format.js do
          @report_document = @report ? @report.document : ReportDocument.new
          if params[:url].present?
            url= params[:url]
            time = Time.now.to_i
            `curl -L #{url} > /tmp/#{time}.xlsx`
            @report_document.file=  File.new("/tmp/#{time}.xlsx")
            @report_document.onedrive_item_id = nil
            @report_document.save!
            `rm /tmp/#{time}.xlsx`
            # redirect_to channel_report_path(@channel, @report)
          elsif params[:one_drive].present?
            current_user.onedrive_access_token = params[:report][:onedrive_token]
            current_user.save!
            url = params[:report][:document]["0"]["@microsoft.graph.downloadUrl"]
            item_id = params[:report][:document]["0"]["id"]
            file_name = params[:report][:document]["0"]["name"]
            File.open("public/uploads/tmp/#{file_name}", 'wb') do |file|
              file << open(url).read
              @report_document.onedrive_item_id = item_id
              @report_document.file = file
            end
            @report_document.save!
            `rm public/uploads/tmp/#{file_name}`
          else
            @report_document.file = params[:report][:document]
            @report_document.onedrive_item_id = nil
            @report_document.save!
          end
          # render report_document: @report_document, status: :ok
          render 'uploader/report_upload'
        end
      end
    end
  end

  def share_report
    @shared_report_with_dashboard = params[:shared_report_with_dashboard]
    if @shared_report_with_dashboard
        @query_id = params[:query_id]
        @dashboards = @report.dashboards
        @shared_dashboards = ReportDashboard.where(pivot_table_id: @query_id).pluck(:dashboard_id)
    else
      @shared_reports = @report.shared_reports.pluck(:user_id)
      @users = User.where.not(id: User.current.id)
      if request.post?
        @report.shared_reports.where(user_id: (@shared_reports.map(&:to_s) - Array.wrap(params[:users]) ) ).where.not(user_id: User.current.id).delete_all
        (Array.wrap(params[:users]) - @shared_reports.map(&:to_s)).each do |user_id|
          @report.shared_reports.create(user_id: user_id)
        end
        flash[:notice] = "Share Report updated successfully"
        redirect_to channel_report_path(@channel, @report)
      end
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user_id = User.current.id
    respond_to do |format|
      if @report.save
        @report_document.update!(report_id: @report.id) if @report_document
        format.html { redirect_to channel_report_path(@channel, @report), notice: 'Data set was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to channel_report_path(@channel, @report), notice: 'Data set was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_pivottable
    pivot_table = SavePivotTable.where(id: params[:query_id]).first_or_initialize
    pivot_table.attributes = params[:save_pivot_table].permit!
    pivot_table.channel_enum_id = params[:save_pivot_table][:channel_enum_id]
    if pivot_table.save
      if params[:query_id]
        flash[:notice] = 'Report was successfully updated'
      else
        flash[:notice] = 'Report was successfully created'
      end
      redirect_to channel_report_path(@channel, @report, query_id: pivot_table.id)
    else
      flash[:alert] = pivot_table.errors.messages
      redirect_to channel_report_path(@channel, @report, new_query: true)
    end
  end

  def delete_pivottable
    if params[:delete_all]
      @report.save_pivot_tables.delete_all
    else
      p = SavePivotTable.find(params[:query_id])
      p.destroy
    end
    flash[:notice] = 'Report was successfully destroyed'
    redirect_to  channel_report_path(@channel, @report)
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to channel_path(@channel), notice: 'Data set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
    @report.frequently_count += 1
    @report.save(touch: false)
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  def change_positions

    if params[:filter_report]
      pivot_table = @report.save_pivot_tables.find(params[:previous_report_position])
      pivot_table.channel_enum_id = params[:new_report_position]
      pivot_table.save!
    elsif  params[:filter_dashboard]
      dashboard = @report.dashboards.find(params[:previous_dashboard_position])
      dashboard.channel_enum_id = params[:new_dashboard_position]
      dashboard.save!
    end
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(Report.safe_attributes)
  end

  def set_repot_document
    @report_document = ReportDocument.find_by_id(params['report']['report_document_ids'].to_i) rescue nil
  end

  def check_one_drive_data
    unless @report&.report_documents&.first&.onedrive_item_id.present?
      flash[:alert] = "Not a OneDrive File!"
      redirect_to channel_report_path(@channel, @report)
    end
  end

  def authorize
    can_access = case params[:action]
                   when 'edit', 'update',
                       'new', 'upload_document',
                       'create', 'save_pivottable'
                    @channel.is_public? || (@channel.is_group? && @channel.my_permission.can_add_report? && @channel.my_permission.can_view?) || (@channel.is_personal? && @channel.is_creator?)
                   when 'delete_pivottable'
                    @channel.is_public? || (@channel.is_group? && @channel.my_permission.can_delete_pivot_table?) || (@channel.is_personal? && @channel.is_creator?)
                   when 'show'
                    @channel.is_public? || (@channel.is_group? && @channel.my_permission.can_view_report? && @channel.my_permission.can_view?) || (@channel.is_personal? && @channel.is_creator?)
                   when 'destroy'
                    @channel.my_permission.can_delete_report? || @channel.is_public?
                   when 'refresh_onedrive_file'
                    @channel.is_public? || (@channel.is_group? && @channel.my_permission.can_add_report?) || (@channel.is_personal? && @channel.is_creator?)
                   else
                    @channel.is_public? || params[:shared_report_with_dashboard].present? ? @channel.my_permission.can_shared_report_with_dashboard? : @channel.my_permission.can_add_users?
                 end

    render_403 unless (can_access || (@report && @report.channel.is_creator?) || (@report.nil? &&  @channel.is_creator?) )
  end
end
