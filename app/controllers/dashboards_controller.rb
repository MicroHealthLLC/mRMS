class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_report
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:index, :show]

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
    pivot_table_ids = JSON.parse(params[:pivot_table_ids]) rescue nil
    if pivot_table_ids.present?
      @dashboard.save_pivot_tables = SavePivotTable.where(id: pivot_table_ids)
      set_order_index_pivot_table(pivot_table_ids)
    end
    respond_to do |format|
      if @dashboard.save
        @save_pivot_tables = @dashboard.save_pivot_tables
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
      pivot_table_ids =  JSON.parse(params[:pivot_table_ids])
      # @dashboard.save_pivot_tables.destroy_all
      @dashboard.save_pivot_tables = SavePivotTable.where(id: pivot_table_ids)
      @save_pivot_tables = @dashboard.save_pivot_tables
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
      ReportDashboard.where(pivot_table_id: pivot_table_id).destroy_all
      dashboards.each do |dashboard|
        report_dashboard = ReportDashboard.find_or_create_by(dashboard_id: dashboard.id, pivot_table_id: pivot_table_id)
      end
      flash[:notice] = "Share Report updated successfully"
    else
      flash[:alert] = "Could not find pivot table"
    end
    redirect_to channel_report_path(@channel, @report)
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
    @dashboard.frequently_count += 1
    @dashboard.save!
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dashboard_params
    params.require(:dashboard).permit(:report_id, :name, :dashboard_enum_id)
  end

  def set_order_index_pivot_table(pivot_table_ids)
    pivot_table_ids.each_with_index do |pivot, index_id|
      @dashboard.report_dashboards.each do |dash|
        if dash.pivot_table_id == pivot
          dash.order_index = index_id
        end
      end
    end
  end

  def authorize
    can_access = case params[:action]
                   when 'edit', 'update',
                       'new',  'create' then  @channel.is_public? or @channel.my_permission.can_shared_report_with_dashboard? or @channel.is_creator?
                   when 'destroy'
                     @report.channel.my_permission.can_delete_report? or @report.channel.is_public? or current_user.id == @dashboard.user_id
                   else
                     @channel.my_permission.can_shared_report_with_dashboard?
                 end

    render_403 unless (can_access or (@report && @report.channel.is_creator?) or (@report.nil? and  @channel.is_creator?) )
  end
end
