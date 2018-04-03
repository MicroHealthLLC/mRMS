class EmployeesController < ProtectForgeryApplication
  before_action  :authenticate_user!
  before_action  :set_employee, :only => [:show, :destroy, :log_in, :update]
  before_action  :authorize
  include UserProfilesHelper
  include ApplicationHelper

  def index
    respond_to do |format|
      format.html{}
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: EmployeeDatatable.new(view_context,options)
      }
    end
  end

  def show
    redirect_to '/profile_record'
    add_breadcrumb 'Client Profile', '/profile_record'
    @languages = Language.for_status(params[:status_type]) if module_enabled?( 'languages')  && can?(:manage_roles, :view_languages, :manage_languages)
    @contacts = Contact.for_status(params[:status_type]) if module_enabled?( 'contacts')  && can?(:manage_roles, :view_contacts, :manage_contacts)
    @affiliations = Affiliation.for_status(params[:status_type]) if module_enabled?( 'affiliations')  && can?(:manage_roles, :view_affiliations, :manage_affiliations)
    @user_insurances = UserInsurance.for_status(params[:status_type]) if module_enabled?( 'insurances')  && can?(:manage_roles, :view_insurances, :manage_insurances)
    @documents = Document.for_profile.for_status(params[:status_type]) if module_enabled?( 'documents')  && can?(:manage_roles, :view_documents, :manage_documents)
    @jsignatures = User.current.jsignatures if module_enabled?( 'jsignatures')
  end

  def new
    r = Role.where(role_type_id: RoleType.default.try(:id)).first
    @user = User.new(state: true, role_id: r.try(:id))
    @user.core_demographic = CoreDemographic.new
    @user.job_detail = JobDetail.new
  end

  def create
    @user = User.new(params.require(:user).permit(employee_params))
    if params[:anonyme_client]
       @user.anonyme_user = true
       @user.email = random_email(params)
    end

    if @user.save
      UserMailer.welcome_email(@user, params[:user][:password]).deliver_later unless @user.anonyme_user?
      redirect_to log_in_employee_path(@user)
    else
      render 'new'
    end
  end

  def update
    if @employee.update(params.require(:user).permit(User.safe_attributes))
      flash[:notice] = I18n.t('notice_successful_update')
    else
      flash[:error] =  @employee.errors.full_messages.join('<br/>')
    end
    redirect_to employee_path(@employee)
  end

  def log_in
    session[:employee_id] = @employee.id
    # flash[:notice]= "Logged In from #{@employee.login}"
    redirect_to employee_path(@employee)
  end

  def destroy
    session[:employee_id] = nil
    # flash[:notice]= "Logged Off from #{@employee.login}"
    redirect_to root_path
  end

  private

  def set_employee
    @employee = User.find params[:id]
    raise Unauthorized if @employee.admin? and !User.current.admin?
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def authorize
    raise Unauthorized unless User.current_user.allowed_to?(:manage_roles)
  end

  def employee_params
    User.current.admin? ? User.admin_safe_attributes :  User.safe_attributes_with_password
  end

  def random_email(params)
    core_params = params[:user][:core_demographic_attributes] ||  {}
    "#{core_params[:first_name]||'user'}.#{core_params[:last_name]}#{rand(252...4350)}#{User.count}@account.com"
  end
end
