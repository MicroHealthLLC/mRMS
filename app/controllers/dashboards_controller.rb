class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_report
  before_action :authorize, except: [:index, :show]
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]



  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = @report.dashboards
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new(report_id: @report.id)
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)
    @dashboard.user_id = User.current.id
    @dashboard.save_pivot_tables = SavePivotTable.where(id: JSON.parse(params[:pivot_table_ids]))
    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to [@channel, @report, @dashboard], notice: 'Dashboard was successfully created.' }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1
  # PATCH/PUT /dashboards/1.json
  def update
    respond_to do |format|
      @dashboard.save_pivot_tables = SavePivotTable.where(id: JSON.parse(params[:pivot_table_ids]))
      if @dashboard.update(dashboard_params)
        format.html { redirect_to [@channel, @report, @dashboard], notice: 'Dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def shared_report
    pivot_table_id = params[:query_id]
    if pivot_table_id
      dashboard_ids = params[:dashboards]
      dashboards = Dashboard.where(id: dashboard_ids)
      dashboards.each do |dashboard|
        report_dashboard = ReportDashboard.find_or_create_by(dashboard_id: dashboard.id, pivot_table_id: pivot_table_id)
      end
      flash[:notice] = "Share Report updated successfully"
      redirect_to channel_report_path(@channel, @report)
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to [@channel, @report], notice: 'Dashboard was successfully destroyed.' }
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
    @report = Report.find(params[:report_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_dashboard
    @dashboard = Dashboard.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dashboard_params
    params.require(:dashboard).permit(:report_id, :name )
  end


  def authorize
    can_access = case params[:action]
                   when 'edit', 'update',
                       'new',  'create' then  @channel.is_public? or @channel.my_permission.can_add_report? or @channel.my_permission.can_view?
                   when 'destroy'
                     @report.channel.my_permission.can_delete_report? or @report.channel.is_public?
                   else
                     @channel.my_permission.can_add_users?
                 end

    render_403 unless (can_access or (@report && @report.channel.is_creator?) or (@report.nil? and  @channel.is_creator?) )
  end
end
