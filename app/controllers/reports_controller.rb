class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_report, only: [:save_pivottable, :delete_pivottable, :share_report, :upload_document, :show, :edit, :update, :destroy]
  before_action :authorize, except: [:index, :show]
  # GET /reports
  # GET /reports.json
  def index
    render_403 unless  @channel.is_public? or @channel.is_creator? or @channel.my_permission.can_view?
    @reports = @channel.visible_reports
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    render_403 unless  @channel.is_public? or @channel.is_creator? or @channel.my_permission.can_view_report?
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
      @report_document = @report.document
      @report_document.file = params[:report][:document]
      @report_document.save
      render 'uploader/report_upload'
    end
  end

  def share_report
    @shared_reports = @report.shared_reports.pluck(:user_id)
    @users = User.where.not(id: User.current.id)
    if request.post?
      @report.shared_reports.where(user_id: (@shared_reports.map(&:to_s) - Array.wrap(params[:users]) ) ).where.not(user_id: User.current.id).delete_all
      (Array.wrap(params[:users]) - @shared_reports.map(&:to_s)).each do |user_id|
        @report.shared_reports.create(user_id: user_id)
      end
      flash[:notice] = "User(s) added successfully"
      redirect_to channel_report_path(@channel, @report)
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user_id = User.current.id
    respond_to do |format|
      if @report.save
        format.html { redirect_to channel_report_path(@channel, @report), notice: 'Report was successfully created.' }
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
        format.html { redirect_to channel_report_path(@channel, @report), notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_pivottable
    p = SavePivotTable.where(id: params[:query_id]).first_or_initialize
    p.attributes = params[:save_pivot_table].permit!
    p.save
    redirect_to channel_report_path(@channel, @report, query_id: p.id)

  end

  def delete_pivottable
    if params[:delete_all]
      @report.save_pivot_tables.delete_all
    else
      p = SavePivotTable.find(params[:query_id])
      p.destroy
    end

    redirect_to  channel_report_path(@channel, @report)
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to channel_path(@channel), notice: 'Report was successfully destroyed.' }
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
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(Report.safe_attributes)
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
                     @channel.my_permission.can_add_users?
                 end

    render_403 unless (can_access or (@report && @report.channel.is_creator?) or (@report.nil? and  @channel.is_creator?) )
  end
end
