class WelcomeController < ApplicationController

  def index
    display_all_public = JSON.parse(params[:display_all_public]) rescue nil
    display_all_personal = JSON.parse(params[:display_all_personal]) rescue nil
    display_all_group = JSON.parse(params[:display_all_group]) rescue nil
    redirect_to new_user_session_path unless user_signed_in?
    @flag1 = true
    @flag2 = true
    @flag3 = true
    @personal_channels = Channel.my_personal_channel.includes(:reports).order(created_at: :desc).limit(3)
    @public_channels = Channel.is_public.includes(:reports).order(created_at: :desc).limit(3)
    @group_channels = Channel.for_user
    if display_all_public
      @public_channels = Channel.is_public.includes(:reports).order(created_at: :desc)
      @flag1 = false
    elsif display_all_personal
      @personal_channels = Channel.my_personal_channel.includes(:reports).order(created_at: :desc)
      @flag2 = false
    elsif display_all_group
      @group_channels = Channel.for_user
      @flag3 = false
    else
    end

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
