class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_report, only: [:save_pivottable, :delete_pivottable, :share_report, :show, :edit, :update, :destroy]
  before_action :authorize, except: [:index, :show]
  before_action :set_repot_document, only: :create

  include ReportsHelper
  # GET /reports/1
  # GET /reports/1.json
  def show
    @query_id = params[:query_id] rescue nil
    @pivot_tables = @report.save_pivot_tables
    @dashboard_count = @report.dashboards.count
    render_403 unless  @channel.is_public? or @channel.is_creator? or @channel.my_permission.can_view_report?
    # if @report.document_url
    #   if params[:query_id] or params[:new_query]
    #     @header, @tab, @error = render_pivot_information(@report.document.file)
    #   end
    # end
  end

  # GET /reports/new
  def new
    @report = Report.new(user_id: User.current.id, channel_id: @channel.id)
  end

  # GET /reports/1/edit
  def edit
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
            @report_document.save!
            `rm /tmp/#{time}.xlsx`
            # redirect_to channel_report_path(@channel, @report)
          elsif params[:one_drive].present?
            url = params[:report][:document]["0"]["@microsoft.graph.downloadUrl"]
            file_name = params[:report][:document]["0"]["name"]
            File.open("public/uploads/tmp/#{file_name}", 'wb') do |file|
              file << open(url).read
              @report_document.file = file
            end
            @report_document.save!
            `rm public/uploads/tmp/#{file_name}`
          else
            @report_document.file = params[:report][:document]
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
    if pivot_table.save
      if params[:query_id]
        flash[:notice] = 'Report was successfully updated'
      else
        flash[:notice] = 'Report was successfully created'
      end
      redirect_to channel_report_path(@channel, @report, query_id: pivot_table.id)
    else
      flash[:notice] = pivot_table.errors.messages
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
    @report.save!
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(Report.safe_attributes)
  end

  def set_repot_document
    @report_document = ReportDocument.find_by_id(params['report']['report_document_ids'].to_i) rescue nil
  end

  def authorize
    can_access = case params[:action]
                   when 'edit', 'update',
                       'new', 'upload_document',
                       'create', 'save_pivottable',
                       'delete_pivottable' then  @channel.is_public? or @channel.my_permission.can_add_report? or @channel.my_permission.can_view?
                   when 'destroy'
                     @report.channel.my_permission.can_delete_report? or @report.channel.is_public?
                   else
                    params[:shared_report_with_dashboard].present? ? @channel.my_permission.can_shared_report_with_dashboard? : @channel.my_permission.can_add_users?
                 end

    render_403 unless (can_access or (@report && @report.channel.is_creator?) or (@report.nil? and  @channel.is_creator?) )
  end
end
