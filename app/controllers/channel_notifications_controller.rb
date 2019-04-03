class ChannelNotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  before_action :set_notification
  before_action :authorize

  def edit
    respond_to do |format|
      format.js do
        @channel_notification.seen = true
        @channel_notification.save
        if params[:accept]

        end

        render js: "$('#channel_notification_#{@channel_notification.id}').hide();"
      end
    end
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
                (!@channel.is_public? && @channel.is_creator?)
              else
                false
              end

    render_403 unless access
  end
end
