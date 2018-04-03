RedCarpet::AccessControl.map do |map|
# case user
  map.project_module :document do |map|
    map.permission :view_documents,   {:client_documents => [:index], :documents => [:index]},  :read => true
    map.permission :show_documents,   {:client_documents => [:show], :documents => [:show]},  :read => true
    map.permission :create_documents, {:client_documents => [:new, :create], :documents => [:new, :create]},  :read => true
    map.permission :edit_documents,   {:client_documents => [ :edit, :update], :documents => [ :edit, :update]},  :read => true
    map.permission :delete_documents, {:client_documents => [ :destroy], :documents => [ :destroy]},  :read => true
    map.permission :manage_documents, {:documents => [:all_files, :index, :show, :new, :create, :edit, :update, :destroy],
                                       :client_documents => [:all_files, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :transports do |map|
    map.permission :view_transports,   {:transports => [:index]},  :read => true
    map.permission :show_transports,   {:transports => [:show]},  :read => true
    map.permission :create_transports, {:transports => [:new, :create]},  :read => true
    map.permission :edit_transports,   {:transports => [ :edit, :update]},  :read => true
    map.permission :delete_transports, {:transports => [ :destroy]},  :read => true
    map.permission :manage_transports, {:transports => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :client_journal do |map|
    map.permission :view_client_journals,   {:client_journals => [:index]},  :read => true
    map.permission :show_client_journals,   {:client_journals => [:show]},  :read => true
    map.permission :create_client_journals, {:client_journals => [:new, :create]},  :read => true
    map.permission :edit_client_journals,   {:client_journals => [ :edit, :update]},  :read => true
    map.permission :delete_client_journals, {:client_journals => [ :destroy]},  :read => true
    map.permission :manage_client_journals, {:client_journals => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :billings do |map|
    map.permission :view_billings,   {:billings => [:index]},  :read => true
    map.permission :show_billings,   {:billings => [:show]},  :read => true
    map.permission :create_billings, {:billings => [:new, :create]},  :read => true
    map.permission :edit_billings,   {:billings => [ :edit, :update]},  :read => true
    map.permission :delete_billings, {:billings => [ :destroy]},  :read => true
    map.permission :manage_billings, {:billings => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :tasks do |map|
    map.permission :view_tasks, {:tasks => [:index]},  :read => true
    map.permission :show_tasks, {:tasks => [:show]},  :read => true
    map.permission :create_tasks, {:tasks => [:link_plan, :add_plan, :new, :create]},  :read => true
    map.permission :edit_tasks, {:tasks => [:edit, :update]},  :read => true
    map.permission :delete_tasks, {:tasks => [:destroy]},  :read => true
    map.permission :manage_tasks, {:tasks => [:delete_sub_task_relation, :link_plan, :add_plan, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :enrollments do |map|
    map.permission :view_enrollments, {:enrollments => [:index]},  :read => true
    map.permission :show_enrollments, {:enrollments => [:show]},  :read => true
    map.permission :create_enrollments, {:enrollments => [ :new, :create]},  :read => true
    map.permission :edit_enrollments, {:enrollments => [:edit, :update]},  :read => true
    map.permission :delete_enrollments, {:enrollments => [:destroy]},  :read => true
    map.permission :manage_enrollments, {:enrollments => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :teleconsults do |map|
    map.permission :view_teleconsults, {:teleconsults => [:index]},  :read => true
    map.permission :show_teleconsults, {:teleconsults => [:show]},  :read => true
    map.permission :create_teleconsults, {:teleconsults => [:new, :create]},  :read => true
    map.permission :edit_teleconsults, {:teleconsults => [:edit, :update]},  :read => true
    map.permission :delete_teleconsults, {:teleconsults => [:destroy]},  :read => true
    map.permission :manage_teleconsults, {:teleconsults => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :referrals do |map|
    map.permission :view_referrals, {:referrals => [:index]},  :read => true
    map.permission :show_referrals, {:referrals => [:show]},  :read => true
    map.permission :create_referrals, {:referrals => [:find_organization, :new, :create]},  :read => true
    map.permission :edit_referrals, {:referrals => [:find_organization, :edit, :update]},  :read => true
    map.permission :delete_referrals, {:referrals => [:destroy]},  :read => true
    map.permission :manage_referrals, {:referrals => [:find_organization, :links, :add_referral, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :notes do |map|
    map.permission :view_notes, {:notes => [:index]},  :read => true
    map.permission :show_notes, {:notes => [:show]},  :read => true
    map.permission :add_notes, {:notes => [:get_template_note, :new, :create]},  :read => true
    map.permission :edit_notes, {:notes => [:get_template_note, :edit, :update]},  :read => true
    map.permission :delete_notes, {:notes => [:destroy]},  :read => true
    map.permission :manage_notes, {:notes => [:get_template_note, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :cases do |map|
    map.permission :view_cases, {:cases => [:index]},  :read => true
    map.permission :view_subcases, {:cases => [:subcases]},  :read => true
    map.permission :show_cases, {:cases => [:show]},  :read => true
    map.permission :my_cases, {:cases => [:my]},  :read => true
    map.permission :create_cases, {:cases => [:new, :create]},  :read => true
    map.permission :edit_cases, {:cases => [:edit, :update]},  :read => true
    map.permission :delete_cases, {:cases => [:destroy]},  :read => true
    map.permission :manage_cases, {:cases => [:timeline, :subcases, :all_files, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :case_watchers do |map|
    map.permission :manage_watchers, {:case_watchers =>  [:index, :show, :edit, :update, :destroy], :cases=> [:watchers]},  :read => true
  end

  map.project_module :case_supports do |map|
    map.permission :view_case_supports, {:case_supports => [:index]},  :read => true
    map.permission :show_case_supports, {:case_supports => [:show]},  :read => true
    map.permission :create_case_supports, {:case_supports => [:new, :create]},  :read => true
    map.permission :edit_case_supports, {:case_supports => [:remove, :edit, :update]},  :read => true
    map.permission :delete_case_supports, {:case_supports => [:destroy]},  :read => true
    map.permission :search_case_supports, {:case_supports => [:search]},  :read => true
    map.permission :manage_case_supports, {:case_supports => [:remove, :index, :show, :search, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :case_organizations do |map|
    map.permission :view_case_organizations, {:case_organizations => [:index]},  :read => true
    map.permission :show_case_organizations, {:case_organizations => [:show]},  :read => true
    map.permission :create_case_organizations, {:case_organizations => [:new, :create]},  :read => true
    map.permission :edit_case_organizations, {:case_organizations => [:edit, :update]},  :read => true
    map.permission :delete_case_organizations, {:case_organizations => [:destroy]},  :read => true
    map.permission :manage_case_organizations, {:case_organizations => [:show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :appointments do |map|
    map.permission :view_appointments, {:appointments => [:calendar, :index]},  :read => true
    map.permission :show_appointments, {:appointments => [:show]},  :read => true
    map.permission :my_appointments, {:appointments => [:my]},  :read => true
    map.permission :create_appointments, {:appointments => [:new, :create]},  :read => true
    map.permission :edit_appointments, {:appointments => [:edit, :update]},  :read => true
    map.permission :delete_appointments, {:appointments => [:destroy]},  :read => true
    map.permission :manage_appointments, {:appointments => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
    map.permission :show_dispositions, {:appointment_dispositions => [:show]},  :read => true
    map.permission :create_dispositions, {:appointment_dispositions => [:new, :create]},  :read => true
    map.permission :edit_dispositions, {:appointment_dispositions => [:edit, :update]},  :read => true
    map.permission :delete_dispositions, {:appointment_dispositions => [:destroy]},  :read => true
    map.permission :manage_dispositions, {:appointment_dispositions => [:calendar, :index, :show, :cms_form, :new, :create, :edit, :update, :destroy]},  :read => true
    map.permission :show_assessment, {:appointment_captures => [:show]},  :read => true
    map.permission :create_assessment, {:appointment_captures => [:new, :create]},  :read => true
    map.permission :edit_assessment, {:appointment_captures => [:edit, :update]},  :read => true
    map.permission :delete_assessment, {:appointment_captures => [:destroy]},  :read => true
    map.permission :manage_assessment, {:appointment_captures => [:calendar, :index, :show, :cms_form, :new, :create, :edit, :update, :destroy]},  :read => true
    map.permission :show_procedures, {:appointment_procedures => [:show]},  :read => true
    map.permission :create_procedures, {:appointment_procedures => [:new, :create]},  :read => true
    map.permission :edit_procedures, {:appointment_procedures => [:edit, :update]},  :read => true
    map.permission :delete_procedures, {:appointment_procedures => [:destroy]},  :read => true
    map.permission :manage_procedures, {:appointment_procedures => [:calendar, :index, :show, :cms_form, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :surveys do |map|
    map.permission :view_surveys, {:surveys => [:index]},  :read => true
    map.permission :create_surveys, {:cases=>[:new_assign_survey], :surveys => [:new, :create]},  :read => true
    map.permission :edit_surveys, {:surveys => [:edit, :update]},  :read => true
    map.permission :delete_surveys, {:surveys => [:destroy]},  :read => true
    map.permission :manage_surveys, {:surveys => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
    map.permission :manage_attempts, {:cases=> [:new_assign_survey], :attempts => [:index, :show, :new, :create, :show]},  :read => true

  end

  map.project_module :needs do |map|
    map.permission :view_needs, {:needs => [:index]},  :read => true
    map.permission :show_needs, {:needs => [:show]},  :read => true
    map.permission :create_needs, {:needs => [:new, :create]},  :read => true
    map.permission :edit_needs, {:needs => [:add_goal, :edit, :update]},  :read => true
    map.permission :delete_needs, {:needs => [:destroy]},  :read => true
    map.permission :manage_needs, {:needs => [:links, :add_goal, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :goals do |map|
    map.permission :view_goals, {:goals => [:index]},  :read => true
    map.permission :show_goals, {:goals => [:show]},  :read => true
    map.permission :create_goals, {:goals => [:new, :create]},  :read => true
    map.permission :edit_goals, {:goals => [:link_need, :add_need, :links, :add_plan, :edit, :update]},  :read => true
    map.permission :delete_goals, {:goals => [:destroy]},  :read => true
    map.permission :manage_goals, {:goals => [:link_need, :add_need, :links, :add_plan, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :plans do |map|
    map.permission :view_plans, {:plans => [:index]},  :read => true
    map.permission :show_plans, {:plans => [:show]},  :read => true
    map.permission :create_plans, {:plans => [:new, :create]},  :read => true
    map.permission :edit_plans, {:plans => [:link_goal, :add_goal,:links, :add_action, :edit, :update]},  :read => true
    map.permission :delete_plans, {:plans => [:destroy]},  :read => true
    map.permission :manage_plans, {:plans => [:link_goal, :add_goal, :links, :add_action, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :measurement_records do |map|
    map.permission :view_measurement_records, {:measurement_records => [:index]},  :read => true
    map.permission :show_measurement_records, {:measurement_records => [:show]},  :read => true
    map.permission :create_measurement_records, {:measurement_records => [:new, :create]},  :read => true
    map.permission :edit_measurement_records, {:measurement_records => [:edit, :update]},  :read => true
    map.permission :delete_measurement_records, {:measurement_records => [:destroy]},  :read => true
    map.permission :manage_measurement_records, {:measurement_records => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :checklists do |map|
    map.permission :view_checklists, {:checklist_cases => [:index]},  :read => true
    map.permission :show_checklists, {:checklist_cases => [:show]},  :read => true
    map.permission :create_checklists, {:checklist_cases => [:new, :create], :cases=> [:new_assign]},  :read => true
    map.permission :edit_checklists, {:checklist_cases => [:edit, :update]},  :read => true
    map.permission :delete_checklists, {:checklist_cases => [:destroy]},  :read => true
    map.permission :manage_checklists, {:cases=> [:new_assign], :checklist_cases => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :worker_compensations do |map|
    map.permission :view_worker_compensations, {:worker_compensations => [:index]},  :read => true
    map.permission :show_worker_compensations, {:worker_compensations => [:show]},  :read => true
    map.permission :create_worker_compensations, {:worker_compensations => [:new, :create]},  :read => true
    map.permission :edit_worker_compensations, {:worker_compensations => [:edit, :update]},  :read => true
    map.permission :delete_worker_compensations, {:worker_compensations => [:destroy]},  :read => true
    map.permission :manage_worker_compensations, {:worker_compensations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :sms do |map|
    map.permission :send_sms, {:sms => [:show, :send_sms]},  :read => true
  end
  
end
