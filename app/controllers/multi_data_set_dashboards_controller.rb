class MultiDataSetDashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_multi_dashboard, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: :show
  def new
    @multi_dashboard = MultiDataSetDashboard.new(channel_id: @channel.id)
  end

  def show
  end

  def create
    @multi_dashboard = MultiDataSetDashboard.new(multi_data_set_dashboard_params)
    @multi_dashboard.user_id = current_user.id
    @multi_dashboard.channel_id = params[:channel_id]
    pivot_table_ids = JSON.parse(params[:pivot_table_ids]) rescue nil
    if pivot_table_ids.present?
      @multi_dashboard.save_pivot_tables = SavePivotTable.where(id: pivot_table_ids)
    end
    respond_to do |format|
      if @multi_dashboard.save
        @save_pivot_tables = @multi_dashboard.save_pivot_tables
        set_order_index_pivot_table(pivot_table_ids)
        format.html { redirect_to [@channel, @multi_dashboard], notice: 'Muti data set dashboard was successfully created.' }
        format.json { render :show, status: :created, location: @multi_dashboard }
      else
        format.html { render :new }
        format.json { render json: @multi_dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    report_ids = @channel.reports.pluck(:id)
    @save_pivot_tables = nil
    if report_ids.present?
      @save_pivot_tables = @multi_dashboard.save_pivot_tables
    end
  end

  def update
    respond_to do |format|
      pivot_table_ids =  JSON.parse(params[:pivot_table_ids])
      @multi_dashboard.save_pivot_tables = SavePivotTable.where(id: pivot_table_ids)
      @save_pivot_tables = @multi_dashboard.save_pivot_tables
      if @multi_dashboard.update(multi_data_set_dashboard_params)
        set_order_index_pivot_table(pivot_table_ids)
        format.html { redirect_to [@channel, @multi_dashboard], notice: 'Muti data set dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @multi_dashboard }
      else
        format.html { render :edit }
        format.json { render json: @multi_dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  @multi_dashboard.destroy
    respond_to do |format|
      format.html { redirect_to [@channel], notice: 'Multi data set dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def set_multi_dashboard
    @multi_dashboard = MultiDataSetDashboard.find(params[:id])
    @multi_dashboard.frequently_count += 1
    @multi_dashboard.save!
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def multi_data_set_dashboard_params
    params.require(:multi_data_set_dashboard).permit(:channel_id, :name, :channel_enum_id )
  end

  def set_order_index_pivot_table(pivot_table_ids)
    pivot_table_ids.each_with_index do |pivot, index_id|
      @multi_dashboard.shared_multi_report_dashboards.each do |dash|
        if dash.pivot_table_id == pivot
          dash.order_index = index_id
          dash.save
        end
      end
    end
  end
  def authorize
    can_access =  case params[:action]
                    when 'new', 'create', 'edit', 'update', 'destroy'
                      then (@channel.is_group? && @channel.my_permission.can_manage_multi_dataset_dashboard?) or @channel.is_public? or (@channel.is_personal? && @channel.is_creator?)
                    else
                      @channel.my_permission.can_shared_report_with_multi_dataset_dashboard? or @channel.is_public?
                  end

    render_403 unless (can_access or (@report && @report.channel.is_creator?) or (@report.nil? and  @channel.is_creator?) )
  end
end
