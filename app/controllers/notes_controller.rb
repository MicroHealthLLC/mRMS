class NotesController < ProtectForgeryApplication
  before_action :set_note, only: [:update, :edit, :show, :destroy]

  def index
    add_breadcrumb I18n.t('notes'), :notes_path

    respond_to do |format|
      format.html{}
      format.json{
        options = Hash.new
        options[:admin] = false
        render json: NoteDatatable.new(view_context,options)
      }
    end
  end

  # TODO make on each breadcrumn it own value
  def new
    @note = Note.new(type: params[:type], owner_id: params[:owner_id], user_id: User.current_user.id)

    if @note.is_a? PostNote
      @breadcrumbs = []
    end
  rescue
    render_404
  end

  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note.object, notice: I18n.t(:notice_successful_create) }
      else
        format.html { render :edit }
      end
    end
  end

  def edit

  end

  def show

  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to  @note.object, notice: I18n.t(:notice_successful_update) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    root = @note.object || notes_url
    @note.destroy
    respond_to do |format|
      format.html { redirect_to root, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])

    set_breadcrumbs

    add_breadcrumb @note.id, @note


    if @note.is_a? PostNote
      @breadcrumbs = []
    elsif @note.is_a? ClientJournalNote
      @breadcrumbs = []
    end

  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    type = if params[:checklist_note]
             :checklist_note
           elsif params[:survey_note]
             :survey_note
           elsif params[:transport_note]
             :transport_note
           elsif params[:case_note]
             :case_note
           elsif params[:task_note]
             :task_note
           elsif params[:referral_note]
             :referral_note
           elsif params[:post_note]
             :post_note
           elsif params[:need_note]
             :need_note
           elsif params[:goal_note]
             :goal_note
           elsif params[:plan_note]
             :plan_note
           elsif params[:job_app_note]
             :job_app_note
           elsif params[:appointment_note]
             :appointment_note
           elsif params[:document_note]
             :document_note
           elsif params[:attempt_note]
             :attempt_note
           elsif params[:client_journal_note]
             :client_journal_note
           else
             :note
           end
    params.require(type).permit(Note.safe_attributes)
  end

  def set_breadcrumbs
   if @note.object.is_a? Document
      if @note.object.try(:case)
        add_breadcrumb @note.object.case, case_path(@note.object.case)
        add_breadcrumb 'Documents', case_path(@note.object.case) + '#tabs-documents'
      else
        @breadcrumbs = []
        add_breadcrumb 'Client Profile', '/profile_record'
        add_breadcrumb 'Client documents', '/profile_record#tabs-documents'
      end
      add_breadcrumb @note.object.to_s, @note.object

      add_breadcrumb I18n.t('notes'), :notes_path
    elsif @note.object.is_a? Post
      add_breadcrumb @note.object.to_s, @note.object

      add_breadcrumb I18n.t('notes'), :notes_path
    end
  end

  def set_owner_case_path
    owner_klass = @note.object.class
    @object_case = @note.object.try(:case)
    return if @object_case.nil?
    tabs_name = case owner_klass.to_s
                  when 'Transport'
                    'transports'
                  when 'Referral'
                    'referrals'
                  when 'Need'
                    'needs'
                  when 'Plan'
                    'plans'
                  when 'Goal'
                    'goals'
                  when 'Task'
                    'tasks'
                  when 'Case'
                    'subcases'
                  when 'Document'
                    'documents'
                  when 'Appointment'
                    "appointments"
                  when 'ChecklistCase'
                    "checklists"
                  else
                    ''

                end
    add_breadcrumb I18n.t(tabs_name), case_path(@object_case) + '#tabs-'+tabs_name if tabs_name.present?
    #   if params[:checklist_note]
    #     :checklist_note
    #   elsif params[:survey_note]
    #     :survey_note
    #   elsif params[:post_note]
    #     :post_note
    #   elsif params[:job_app_note]
    #     :job_app_note
    #
  end
end
