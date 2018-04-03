RedCarpet::AccessControl.map do |map|

  map.project_module :organizations do |map|
    map.permission :manage_user_job_details, {:job_details => [:create, :update]},  :read => true
    map.permission :view_organizations, {:organizations => [:index]},  :read => true
    map.permission :show_organizations, {:organizations => [:show]},  :read => true
    map.permission :create_organizations, {:organizations => [:new, :create]},  :read => true
    map.permission :edit_organizations, {:organizations => [:edit, :update]},  :read => true
    map.permission :delete_organizations, {:organizations => [:destroy]},  :read => true
    map.permission :manage_organizations, {:job_details => [:create, :update], :organizations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end


  map.project_module :form_details do |map|
    map.permission :view_form_details, {:form_details => [:index]},  :read => true
    map.permission :show_form_details, {:form_details => [:show]},  :read => true
    map.permission :create_form_details, {:form_details => [:new, :create]},  :read => true
    map.permission :edit_form_details, {:form_details => [:edit, :update]},  :read => true
    map.permission :delete_form_details, {:form_details => [:destroy]},  :read => true
    map.permission :manage_form_details, {:form_details => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end


  map.project_module :employee do |map|
    map.permission :view_collaborate, {},  :read => true
    map.permission :view_personal_organizer, {},  :read => true
    map.permission :manage_roles, {
        :sms => [:show, :send_sms],
        :employees => [:index],
        :identifications => [:index, :show, :new, :create, :edit, :update, :destroy],
        :educations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :formulars => [:index, :show, :new, :create, :edit, :update, :destroy],
        :form_details => [:index, :show, :new, :create, :edit, :update, :destroy],
        :transports => [:index, :show, :new, :create, :edit, :update, :destroy],
        :languages => [:index, :show, :new, :create, :edit, :update, :destroy],
        :daily_livings => [:index, :show, :new, :create, :edit, :update, :destroy],
        :affiliations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :clearances => [:index, :show, :new, :create, :edit, :update, :destroy],
        :user_insurances => [:index, :show, :new, :create, :edit, :update, :destroy],
        :certifications => [:index, :show, :new, :create, :edit, :update, :destroy],
        :contacts => [:search, :index, :show, :new, :create, :edit, :update, :destroy, :remove],
        :chat_rooms => [:conference, :show, :create_or_find],
        :document => [:all_files, :index, :new, :show, :create, :edit, :update, :destroy],
        :other_skills => [:index, :new, :show, :create, :edit, :update, :destroy],
        :injuries => [:index, :show, :new, :create, :edit, :update, :destroy],
        :worker_compensations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :job_applications => [:index, :show, :new, :create, :edit, :update, :destroy],
        :job_apps => [:index, :show, :new, :create, :edit, :update, :destroy],
        :jobs => [:index, :show, :new, :create, :edit, :update, :destroy],
        :positions => [:index, :show, :new, :create, :edit, :update, :destroy],
        :admissions => [:index, :show, :new, :create, :edit, :update, :destroy],
        :housings => [:index, :show, :new, :create, :edit, :update, :destroy],
        :medicals => [:index, :show, :new, :create, :edit, :update, :destroy],
        :medications => [:index, :show, :new, :create, :edit, :update, :destroy],
        :other_histories => [:index, :show, :new, :create, :edit, :update, :destroy],
        :family_histories => [:index, :show, :new, :create, :edit, :update, :destroy],
        :allergies => [:index, :show, :new, :create, :edit, :update, :destroy],
        :problem_lists => [:index, :show, :new, :create, :edit, :update, :destroy],
        :behavioral_risks => [:index, :show, :new, :create, :edit, :update, :destroy],
        :immunizations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :surgicals => [:index, :show, :new, :create, :edit, :update, :destroy],
        :jsignatures => [:index, :show, :new, :create],
        :environment_risks => [:index, :show, :new, :create, :edit, :update, :destroy],
        :socioeconomics => [:index, :show, :new, :create, :edit, :update, :destroy],
        :service_histories => [:index, :show, :new, :create, :edit, :update, :destroy],
        :units => [:index, :show, :new, :create, :edit, :update, :destroy],
        :awards => [:index, :show, :new, :create, :edit, :update, :destroy],
        :deployment_histories => [:index, :show, :new, :create, :edit, :update, :destroy],
        :incident_histories => [:index, :show, :new, :create, :edit, :update, :destroy],
        :mtf_hospitals => [:index, :show, :new, :create, :edit, :update, :destroy],
        :health_care_facilities => [:index, :show, :new, :create, :edit, :update, :destroy],
        :teleconsults => [:index, :show, :new, :create, :edit, :update, :destroy],
        :legals => [:index, :show, :new, :create, :edit, :update, :destroy],
        :billings => [:index, :show, :new, :create, :edit, :update, :destroy],
        :financials => [:index, :show, :new, :create, :edit, :update, :destroy],
        :organizations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :job_details => [:create, :update],
        :transportations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :radiologic_examinations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :laboratory_examinations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :resumes => [:index, :show, :new, :create, :edit, :update, :destroy],
        :related_clients => [:index, :show, :new, :create, :edit, :update, :destroy],
        :surveys => [:new_assign_survey, :index, :show, :new, :create, :edit, :update, :destroy, :show],
        :attempts => [:index, :show, :new, :create],
        :tasks => [:delete_sub_task_relation, :link_plan, :add_plan, :index, :my, :show, :new, :create, :edit, :update, :destroy],
        :cases => [:timeline, :new_assign, :my, :all_files, :subcases, :watchers, :index, :show, :new, :create, :edit, :update, :destroy],
        :case_supports => [:search, :index, :show, :new, :create, :edit, :update, :destroy],
        :case_watchers => [:index, :show, :edit, :update, :destroy],
        :appointments => [:calendar, :my, :index, :show, :cms_form, :new, :create, :edit, :update, :destroy],
        :appointment_captures => [:show, :new, :create, :edit, :update, :destroy],
        :appointment_dispositions => [:show, :new, :create, :edit, :update, :destroy],
        :appointment_procedures => [:show, :new, :create, :edit, :update, :destroy],
        :needs => [:links, :add_goal, :index, :show, :new, :create, :edit, :update, :destroy],
        :news => [:index, :show, :new, :create, :edit, :update, :destroy],
        :referrals => [:links, :add_referral, :find_organization, :index, :show, :new, :create, :edit, :update, :destroy],
        :notes => [:index, :show, :new, :create, :edit, :update, :destroy, :get_template_note],
        :plans => [:link_goal, :add_goal, :links, :add_action, :index, :show, :new, :create, :edit, :update, :destroy],
        :measurement_records => [:index, :show, :new, :create, :edit, :update, :destroy],
        :goals => [:link_need, :add_need, :links, :add_plan, :index, :show, :new, :create, :edit, :update, :destroy],
        :checklist_cases => [:index, :show, :new, :create, :edit, :update, :destroy],
        :case_organizations => [:show, :new, :create, :edit, :update, :destroy],
        :sticky => [:index, :save],
        :user_cases => [:add_appointment_link, :unlink_appointment, :set_appointment_store_id],
        :wikis => [:new, :index, :show, :create, :edit, :update, :history, :compare, :add_attachment, :destroy],
        "rordit/links" => [:index, :show, :get_search_results, :get_link, :get_popular_links, :get_newest_links, :new, :create],
        "rordit/comments" => [:new, :create],
        "rordit/points" => [:give_point_to_link, :give_point_to_comment],
        'sticky_notes/sticky_notes' => [:index, :save],
        'todo_list/todos' => [:index, :save],
        'kanban/projects' => [:index, :create, :update, :destroy, :manage_users],
        'kanban/columns' => [:index, :create, :update, :destroy],
        'kanban/cards' => [:index, :create, :update, :destroy, :change_column, :archive, :unarchive ],
        'event_calendar/events' => [:index, :new, :show, :edit, :create, :update, :destroy],
        'inventory/product_assigns' => [:index, :new, :show, :edit, :create, :update, :destroy],
        'links/links' => [:index, :new, :show, :edit, :create, :update, :destroy],
        :document_managers => [:new_folder, :index, :show, :search, :destroy, :create, :update, :download],
        :revisions=>[:download, :create]

    },  :read => true
  end
end
