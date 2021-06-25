class WelcomeController < ApplicationController

  def index
    redirect_to new_user_session_path unless user_signed_in?
    @personal_channels = Channel.my_personal_channel.includes(:reports)
    @public_channels = Channel.is_public.includes(:reports)
    @group_channels = Channel.for_user
    session[:appointment_store_id] = nil if User.current_user.can?(:manage_roles)
    if session[:employee_id]
      session[:appointment_store_id] = nil
      @employee = User.find session[:employee_id]
      session[:employee_id] = nil
      # flash[:notice]= "Logged Off from #{@employee.login}"
      redirect_to root_path
    end
    @setting = Setting.first || Setting.new
  end

  def onedriveredirect
  end
end
