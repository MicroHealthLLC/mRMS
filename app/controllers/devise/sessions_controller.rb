class Devise::SessionsController < DeviseController
  prepend_before_action :require_no_authentication, only: [:new, :create]
  prepend_before_action :allow_params_authentication!, only: :create
  prepend_before_action :verify_signed_out_user, only: :destroy
  prepend_before_action(only: [:create, :destroy]) { request.env["devise.skip_timeout"] = true }
  prepend_before_action :check_captcha, only: [:create] if ENV['RECAPTCHA_PUBLIC_KEY'].present?
  prepend_before_action :check_whitelists, only: [:create]
  prepend_before_action :check_blacklists, only: [:create]

  # GET /resource/sign_in
  def new
    @setting = Setting.first || Setting.new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.state == 'active'
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      sign_out()
      set_flash_message!(:alert, :inactive)
      respond_with_navigational(resource) { render :new }
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  protected

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { methods: methods, only: [:password] }
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end

  def translation_scope
    'devise.sessions'
  end

  private

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new devise_parameter_sanitizer.sanitize(:sign_in)
      respond_with_navigational(resource) { render :new }
    end
  end

  def check_whitelists
    unless regexp_match?(Setting['whitelist_ip'], request.remote_ip)
      self.resource = resource_class.new devise_parameter_sanitizer.sanitize(:sign_in)
      respond_with_navigational(resource) { render :new }
    end
  end

  def check_blacklists
    if regexp_match?(Setting['blacklist_ip'], request.remote_ip, false)
      self.resource = resource_class.new devise_parameter_sanitizer.sanitize(:sign_in)
      respond_with_navigational(resource) { render :new }
    end
  end

  def regexp_match?(list, remote_ip, b = true)
    return b if list.strip.blank?
    list.split(',').each do |str|
      ip = Regexp.new "#{str.strip}".gsub('*', '[0-9]{1,3}')
      return true if remote_ip =~ ip
    end
    false
  end

  def check_whitelist_ip(remote_ip = '')
    return true if whitelist_ip.blank?
    whitelist_ip.split(',').each do |str|
      ip = Regexp.new str.strip
      return true if remote_ip =~ ip
    end
    false
  end

  # Check if there is no signed in user before doing the sign out.
  #
  # If there is no signed in user, it will set the flash message and redirect
  # to the after_sign_out path.
  def verify_signed_out_user
    if all_signed_out?
      set_flash_message! :notice, :already_signed_out

      respond_to_on_destroy
    end
  end

  def all_signed_out?
    users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

    users.all?(&:blank?)
  end

  def respond_to_on_destroy
    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
    end
  end
end
