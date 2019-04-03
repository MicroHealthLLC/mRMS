class ChannelPermissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_permission, only: :destroy
  before_action :authorize, except: [:leave_channel]

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

  def update
    @permission = ChannelPermission.find(params[:id])
    if @permission.update(params[:channel_permission].permit!)
      flash[:notice] = "Success"
      render js: 'location.reload();'
    else
      render js: "alert('#{@permission.errors.full_messages.join('<br/>').html_safe}')"
    end
  end

  def destroy
    @permission.destroy
    flash[:notice] = "Success"
    redirect_back fallback_location: root_path
  end

  def leave_channel
    ChannelNotification.create(channel_id: @channel.id, user_id: User.current.id, notification_type: 1)
    ChannelPermission.where(channel_id: @channel, user_id: User.current.id).first&.destroy
    flash[:notice] = 'You left the channel'
    redirect_to root_path
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

  def authorize
    access =  if @channel
                @channel.is_public? or @channel.is_creator? or (@channel.my_permission.can_view? and @channel.my_permission.can_add_users? )
              else
                false
              end

    render_403 unless access
  end

end
