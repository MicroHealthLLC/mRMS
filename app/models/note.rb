class Note < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  scope :not_private, -> {where(is_private: false)}
  default_scope -> {where(is_private: false).or(where(private_author_id: User.current_user.id)).includes(:user) }

  CASES_MODULE = [  'TaskNote'           ,
                    'SurveyNote'         ,
                    'CaseNote'           ,
                    'ChecklistNote'      ,
                    'AppointmentNote'    ,
                    'NeedNote'           ,
                    'GoalNote'           ,
                    'PlanNote'           ,
                    'DocumentNote'       ,
                    'AttemptNote'        ,
                    'ReferralNote'
  ]
  validates_presence_of :type, :owner_id, :note

  def self.safe_attributes
    [:user_id, :owner_id, :type, :note, :is_private, :private_author_id]
  end

  before_create :check_private_author

  def check_private_author
    if self.is_private
      self.private_author_id = User.current_user.id
    end
  end

  def object

  end

  def for_type
    case type
      when 'TaskNote'           then I18n.t('task')
      when 'SurveyNote'         then I18n.t('survey')
      when 'PostNote'           then 'News'
      when 'CaseNote'           then I18n.t('case')
      when 'ChecklistNote'      then I18n.t('checklist')
      when 'AppointmentNote'    then I18n.t('appointments')
      when 'NeedNote'           then I18n.t('need')
      when 'GoalNote'           then I18n.t('goal')
      when 'PlanNote'           then I18n.t('plan')
      when 'DocumentNote'       then I18n.t('document')
      when 'AttemptNote'        then 'Attempt'
      when 'ReferralNote'       then 'Referral'
      when 'ClientJournalNote'  then 'ClientJournal'
      else
        I18n.t('label_note')
    end
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Note ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Note "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Created at: ", " #{created_at.to_date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Belongs to: ", " #{object}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def to_s
    "#{self.class} ##{id}"
  end

end

require_dependency 'task_note'
require_dependency 'checklist_note'
require_dependency 'post_note'
require_dependency 'case_note'
require_dependency 'survey_note'
require_dependency 'appointment_note'
require_dependency 'goal_note'
require_dependency 'plan_note'
require_dependency 'need_note'
require_dependency 'document_note'
require_dependency 'attempt_note'
