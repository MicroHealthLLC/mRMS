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
      change = @channel.reports.find(params[:previous_report_position])
      change.report_enum_id = params[:new_report_position]
      change.save!
    elsif  params[:filter_dashboard]

      change = @channel.multi_data_set_dashboards.find(params[:previous_dashboard_position])
      change.dashboard_enum_id = params[:new_dashboard_position]
      change.save!
    end
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def channel_params
    params.require(:channel).permit(Channel.safe_attributes)
  end

  def authorize
    access =  if @channel and params[:action]!="update"
               @channel.is_public? or (@channel.is_creator? and @channel.is_personal?) or  (@channel.is_group? and @channel.my_permission.can_view? and @channel.my_permission.can_add_report? )
              elsif params[:action] == "update" and @channel
                User.current.admin?
              else
                true
              end

    render_403 unless access
  end
end
