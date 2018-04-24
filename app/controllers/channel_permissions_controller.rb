class ChannelPermissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_permission, only: :destroy

  def index
    @permissions = @channel.channel_permissions
    @permission = ChannelPermission.new
  end

  def create
    @permission = @channel.channel_permissions.new(params[:channel_permission].permit!)
    if @permission.save
      flash[:notice] = "Success"
      render js: 'location.reload();'
    else
      render js: "alert('#{@permission.errors.full_messages.join('<br/>').html_safe}')"
    end
  end

  def destroy
    @permission.destroy
    redirect_to :back
  end

  private

  def set_permission
    @permission = @channel.channel_permissions.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  def set_channel
    @channel = Channel.find(params[:channel_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
