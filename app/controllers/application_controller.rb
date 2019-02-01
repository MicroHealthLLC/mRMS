class Unauthorized < Exception; end

class ApplicationController < ActionController::Base
  # rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
  #   render :text => exception, :status => 500
  # end
  before_action :set_user
  before_action :set_enabled_modules
  before_action :module_visible

  around_action :user_time_zone, :if => :current_user
  layout 'base'
  def set_enabled_modules
    @enabled_modules =  EnabledModule.active.pluck(:name).to_set
  end

  rescue_from ActiveRecord::ValueTooLong do |exception|
    flash[:error] = exception.message
    redirect_to root_path
  end

  def set_user
    if user_signed_in?
      User.current_user = current_user

      # if session[:employee_id]
      #   User.current = User.find session[:employee_id]
      #   @user = User.current
      # elsif params[:user_id]
      #   @user = User.find params[:user_id]
      #   User.current = current_user
      # elsif params[:employee_id]
      #   User.current = User.find params[:employee_id]
      #   @user = User.current
      #   session[:employee_id] = User.current.id
      # else
        User.current = current_user
      #   @user = User.current
      # end
      # current_user.last_seen_at =  Time.now
      current_user.save(validate: false)
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def module_visible
    render_404 if EnabledModule.where(name: params[:controller], status: false).present?
  end

  def authorize(ctrl = params[:controller], action = params[:action])
    User.current.admin?
  end
  rescue_from ::Unauthorized, :with => :deny_access

  def deny_access
    User.current ? render_403 : require_login
  end

  def require_login
    redirect_to new_session_path(:user) unless User.current.persisted?
  end

  def render_403(options={})
    @project = nil
    render_error({:message => :notice_not_authorized, :status => 403}.merge(options))
    return false
  end

  def render_404(options={})
    render_error({:message => :notice_file_not_found, :status => 404}.merge(options))
    return false
  end

  # Renders an error response
  def render_error(arg)
    arg = {:message => arg} unless arg.is_a?(Hash)

    @message = arg[:message]
    @message = @message if @message.is_a?(Symbol)
    @status = arg[:status] || 500

    respond_to do |format|
      format.html {
        render :template => 'common/error', :layout => 'base', :status => @status
      }
      format.any { head @status }
    end
  end

  def require_admin
    render_404 unless User.current.admin?
  end

  private

  def user_time_zone(&block)
    Time.use_zone(User.current.time_zone, &block)
  end
end