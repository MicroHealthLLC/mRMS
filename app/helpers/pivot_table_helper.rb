module PivotTableHelper
  def render_pivot_information(table)
    case table
      when 'affiliation' then render_affiliation
      when 'clearance' then render_clearance
      when 'certification' then render_certification
      when 'contact' then render_contact
      when 'education' then render_education
      when 'language' then render_language
      when 'document' then render_document
      when 'position' then render_position
      when 'task' then render_task
      when 'checklist' then render_checklist
      when 'case' then render_case
      when 'survey' then render_survey
      when 'appointment' then render_appointment
      when 'note' then render_note
      else
        render_user
    end

  end

  def render_user
   CoreDemographic.includes(:user, :citizenship_type).
       references(:user, :citizenship_type).map do |object|
     {
         user: object.user,
         first_name: object.first_name,
         last_name: object.last_name,
         ethnicity: object.ethnicity,
         citizenship: object.citizenship_type,
         gender: object.gender,
         religion: object.religion,


     }
   end
  end

  def render_position
    Position.includes(:user=> [:core_demographic]).
        references(:user=> [:core_demographic]).map do |position|
      {
          user: position.user,
          salary: position.salary,
          pay_rate: position.pay_rate_type,
          location: position.location_type,
          employment_type: position.employment_type

      }
    end
  end

  def render_checklist
    ChecklistTemplate.includes(:user).
        references(:user).map do |ct|
      {
          user: ct.user,
          title: ct.title

      }
    end
  end

  def render_document
    Document.includes(:user, :document_type).
        references(:user, :document_type).map do |document|
      {
          user: document.user,
          document_type: document.document_type,
          title: document.title

      }
    end
  end

  def render_language
    Language.includes(:user, :proficiency_type).
        references(:user, :proficiency_type).map do |lang|
      {
          user: lang.user,
          language_type: lang.language_type,
          proficiency: lang.proficiency_type

      }
    end
  end

  def render_affiliation
    Affiliation.includes(:user, :affiliation_type).
        references(:user, :affiliation_type).map do |affiliation|
      {
          user: affiliation.user,
          name: affiliation.name,
          affiliation_type: affiliation.affiliation_type

      }
    end
  end

  def render_case
    Case.unscoped.includes(:assigned_to, :case_type, :case_status_type).
        references(:assigned_to, :case_type, :case_status_type).map do |c|
      {
          user: c.assigned_to,
          title: c.title,
          category: c.case_category_type,
          status: c.case_status_type,
          date_start: c.date_start,
          date_due: c.date_due,
          priority: c.priority_type,
          case_type: c.case_type
      }
    end
  end

  def render_survey
    Survey::Survey.includes( :survey_type).
        references(:survey_type).map do |survey|
      {
          name: survey.name,
          attempts_number: survey.attempts_number,
          survey_type: survey.survey_type
      }
    end
  end

   def render_appointment
    Appointment.includes( :appointment_type, :appointment_status, :user=> [:core_demographic]).
        map do |appointment|
      {
          user: appointment.user,
          title: appointment.title,
          date: appointment.date,
          appointment_type: appointment.appointment_type,
          appointment_status: appointment.appointment_status
      }
    end
  end

   def render_note
    Note.includes(:user=> :core_demographic).map do |note|
      {
          user: note.user,
          belongs_to: note.for_type
      }
    end
  end

  def render_clearance
    Clearance.includes(:user, :clearence_type).
        references(:user, :clearence_type).map do |clearance|
      {
          user: clearance.user,
          date_received: clearance.date_received,
          date_expired: clearance.date_expired,
          clearance_type: clearance.clearence_type

      }
    end
  end

  def render_certification
    Certification.includes(:user, :certification_type).
        references(:user, :certification_type).map do |object|
      {
          user: object.user,
          date_received: object.date_received,
          date_expired: object.date_expired,
          certification_type: object.certification_type
      }
    end
  end

  def render_contact
    Contact.includes(:user, :contact_type).
        references(:user, :contact_type).map do |object|
      {
          user: object.user,
          contact_type: object.contact_type
      }
    end
  end

  def render_education
    Education.includes(:user, :education_type).
        references(:user, :education_type).all.map do |object|
      {
          user: object.user.to_s,
          date_recieved: object.date_recieved.to_s,
          date_expired: object.date_expired.to_s,
          education_type: object.education_type
      }
    end
  end



  def render_task
    Task.includes(:assigned_to, :for_individual).references(:assigned_to, :for_individual).all.map do |task|
      {
          user: task.assigned_to,
          task_type: task.task_type,
          priority_type: task.priority_type,
          for_individual: task.for_individual,
          date_start: task.date_start,
          date_due: task.date_due,
          date_completed: task.date_completed
      }
    end
  end
end
