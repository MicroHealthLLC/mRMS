class ChannelNotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_notification, except: :new
  before_action :authorize, only: :edit

  def new
    ChannelNotification.create(channel_id: @channel.id,
                               user_id: User.current.id,
                               seen: false,
                               notification_type: ChannelNotification::REQUEST

    )
    redirect_back fallback_location: root_path
  end

  def edit
    respond_to do |format|
      format.js do
        @channel_notification.seen = true
        @channel_notification.save
      end
    end
  end

  def destroy
    @channel_notification.destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def set_notification
    @channel_notification = @channel.channel_notifications.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def authorize
    access =  if @channel
                (!@channel.is_public? && (@channel.is_creator? || @channel.channel_permissions.where(channel_permissions: {user_id: User.current.id, can_add_users: true}).present?))
              else
                false
              end

    render_403 unless access
  end
end
