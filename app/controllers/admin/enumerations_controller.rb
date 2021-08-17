
class EnumerationsController < ProtectForgeryApplication
  before_action  :authenticate_user!

  before_action :require_admin
  before_action :build_new_enumeration, :only => [:new, :create]
  before_action :find_enumeration, :only => [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html{}
    end
  end

  def new
  end

  def create
    if request.post? && @enumeration.save
      flash[:notice] = I18n.t(:notice_successful_create)
      redirect_to enumerations_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @enumeration.update_attributes(params.require(:enumeration).permit(Enumeration.safe_attributes))
      respond_to do |format|
        format.html {
          flash[:notice] = I18n.t "notice_successful_update"
          redirect_to enumerations_path
        }
        format.js { render js: 'alert("Saved")' }
      end
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.js { render :nothing => true, :status => 422 }
      end
    end
  end

  def destroy
    if !@enumeration.in_use?
      # No associated objects
      @enumeration.destroy
      redirect_to enumerations_path
      return
    elsif params[:reassign_to_id].present? && (reassign_to = @enumeration.class.find_by_id(params[:reassign_to_id].to_i))
      @enumeration.destroy(reassign_to)
      redirect_to enumerations_path
      return
    end
    @enumerations = @enumeration.class.where(nil).to_a - [@enumeration]
  end

  def upload
    enum = Enumeration.get_subclasses.detect{|e| e.to_s == params[:type]}
    if enum
      sseu = SpreadsheetEnumerationUpload.new(params[:file])
      sseu.upload_enumeration(enum)
      flash[:notice] = 'Upload done'
      redirect_to enumeration_path(enum)
    else
      flash[:error] = 'Type not found'
      redirect_to root_path
    end

  end

  private

  def build_new_enumeration
    class_name = params[:enumeration] && params[:enumeration][:type] || params[:type]

    @enumeration = Enumeration.new_subclass_instance(class_name, params[:action]=='new' ? params[:enumeration] : params.require(:enumeration).permit(Enumeration.safe_attributes))
    if @enumeration.nil?
      render_404
    end
  end

  def find_enumeration
    @enumeration = Enumeration.find(params[:id])
    if @enumeration.name.capitalize == "Uncategorized"
      redirect_to enumerations_path
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end

