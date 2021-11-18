class ChannelsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_channel, only: [:manage_users, :show, :edit, :update, :destroy]
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:index]
  before_action :require_admin, only: [:index]
  before_action :change_positions, only: :show

  def index
  end

  def reorder_handle
    channel_position = User.current.channel_orders.where(channel_id: params[:channel_id]).first
    channel_position.position = params[:channel][:position]
    channel_position.save
    respond_to do |format|
      format.html {
      }
      format.js { render js: '' }
    end
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    reports = @channel.shared_report? ? User.current.reports.current_user_shared_reports : @channel.reports
    @reports = reports.where(channel_id: Channel.pluck(:id)).paginate(page: params[:page], per_page: 10)
  end

  # GET /channels/new
  def new
    @channel = Channel.new(user_id: User.current.id)
  end

  # GET /channels/1/edit
  def edit
    render_403 unless @channel.is_creator? or @channel.my_permission.can_edit?
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)

    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel }
        format.js {render js: 'alert("Saved")'}
      else
        format.html { render :edit }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
        format.js {render js: "alert('Error: #{@channel.errors.full_messages.join(',')}')"}
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    if @channel.is_creator? || User.current.admin?
      # @channel.is_active = false
      # ChannelOrder.where(channel_id: @channel.id).delete_all
      @channel.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Channel was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      render_403
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.unscoped.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def change_positions
    if params[:filter_report]
      reports = User.current.reports.current_user_shared_reports
      report = @channel.shared_report? ? reports.find(params[:previous_report_position]) : @channel.reports.find(params[:previous_report_position])
      report.channel_enum_id = params[:new_report_position]
      report.save!
    elsif  params[:filter_dashboard]
      multi_dashboard = @channel.multi_data_set_dashboards.find(params[:previous_dashboard_position])
      multi_dashboard.channel_enum_id = params[:new_dashboard_position]
      multi_dashboard.save!
    end
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def channel_params
    params.require(:channel).permit(Channel.safe_attributes)
  end

  def authorize
    access =  if @channel && ["update", "edit", "destroy"].exclude?(params[:action])
               @channel.is_public? || (@channel.is_creator? && @channel.is_personal?) || (@channel.is_group? && @channel.my_permission.can_view?)
              elsif params[:action] == "update" || params[:action] == "edit" && @channel
                User.current.admin? || @channel.is_creator? || (@channel.is_group? && @channel.my_permission.can_edit?)
              elsif params[:action] == "destroy" && @channel
                @channel.is_creator?
              else
                true
              end

    render_403 unless access
  end
end
