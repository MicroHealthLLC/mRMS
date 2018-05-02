class ChannelsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_channel, only: [:manage_users, :show, :edit, :update, :destroy]
  before_action :set_channel, only: [ :show, :edit, :update, :destroy]
  before_action :authorize

  # GET /channels/1
  # GET /channels/1.json
  def show
    @reports = @channel.visible_reports
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

  # def manage_users
  #   @shared_channels = @channel.channel_users.pluck(:user_id)
  #   @users = User.where.not(id: User.current.id)
  #   if request.post?
  #     @channel.channel_users.where(user_id: (@shared_channels.map(&:to_s) - params[:users]) ).where.not(user_id: User.current.id).delete_all
  #     (params[:users] - @shared_channels.map(&:to_s)).each do |user_id|
  #       @channel.channel_users.create(user_id: user_id)
  #     end
  #     flash[:notice] = "User(s) added successfully"
  #     redirect_to channel_path(@channel)
  #   end
  # end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    if @channel.is_creator? or User.current.can?(:manage_roles)
      @channel.is_active = false
      @channel.save
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
    @channel = Channel.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def channel_params
    params.require(:channel).permit(Channel.safe_attributes)
  end

  def authorize
    if @channel
      @channel.is_creator? or (@channel.my_permission.can_add_report? or @channel.can?(:edit_channel, :manage_channel, :manage_roles) )
    else
      true
    end
  end
end
