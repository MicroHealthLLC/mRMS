RedCarpet::AccessControl.map do |map|
# Medical HISTORY

  map.project_module :admissions do |map|
    map.permission :view_admissions, {:admissions => [:index]},  :read => true
    map.permission :show_admissions, {:admissions => [:show]},  :read => true
    map.permission :create_admissions, {:admissions => [:new, :create]},  :read => true
    map.permission :edit_admissions, {:admissions => [ :edit, :update]},  :read => true
    map.permission :delete_admissions, {:admissions => [:destroy]},  :read => true
    map.permission :manage_admissions, {:admissions => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :health_care_facilities do |map|
    map.permission :view_health_care_facilities, {:health_care_facilities => [:index]},  :read => true
    map.permission :show_health_care_facilities, {:health_care_facilities => [:show]},  :read => true
    map.permission :create_health_care_facilities, {:health_care_facilities => [:new, :create]},  :read => true
    map.permission :edit_health_care_facilities, {:health_care_facilities => [ :edit, :update]},  :read => true
    map.permission :delete_health_care_facilities, {:health_care_facilities => [:destroy]},  :read => true
    map.permission :manage_health_care_facilities, {:health_care_facilities => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :problem_lists do |map|
    map.permission :view_problem_lists, {:problem_lists => [:index]},  :read => true
    map.permission :show_problem_lists, {:problem_lists => [:show]},  :read => true
    map.permission :create_problem_lists, {:problem_lists => [:new, :create]},  :read => true
    map.permission :edit_problem_lists, {:problem_lists => [ :edit, :update]},  :read => true
    map.permission :delete_problem_lists, {:problem_lists => [:destroy]},  :read => true
    map.permission :manage_problem_lists, {:problem_lists => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :surgicals do |map|
    map.permission :view_surgicals, {:surgicals => [:index]},  :read => true
    map.permission :show_surgicals, {:surgicals => [:show]},  :read => true
    map.permission :create_surgicals, {:surgicals => [:new, :create]},  :read => true
    map.permission :edit_surgicals, {:surgicals => [ :edit, :update]},  :read => true
    map.permission :delete_surgicals, {:surgicals => [:destroy]},  :read => true
    map.permission :manage_surgicals, {:surgicals => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
  map.project_module :medicals do |map|
    map.permission :view_medicals, {:medicals => [:index]},  :read => true
    map.permission :show_medicals, {:medicals => [:show]},  :read => true
    map.permission :create_medicals, {:medicals => [:new, :create]},  :read => true
    map.permission :edit_medicals, {:medicals => [ :edit, :update]},  :read => true
    map.permission :delete_medicals, {:medicals => [:destroy]},  :read => true
    map.permission :manage_medicals, {:medicals => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
  map.project_module :medications do |map|
    map.permission :view_medications, {:medications => [:index]},  :read => true
    map.permission :show_medications, {:medications => [:show]},  :read => true
    map.permission :create_medications, {:medications => [:new, :create]},  :read => true
    map.permission :edit_medications, {:medications => [ :edit, :update]},  :read => true
    map.permission :delete_medications, {:medications => [:destroy]},  :read => true
    map.permission :manage_medications, {:medications => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
  map.project_module :behavioral_risks do |map|
    map.permission :view_behavioral_risks, {:behavioral_risks => [:index]},  :read => true
    map.permission :show_behavioral_risks, {:behavioral_risks => [:show]},  :read => true
    map.permission :create_behavioral_risks, {:behavioral_risks => [:new, :create]},  :read => true
    map.permission :edit_behavioral_risks, {:behavioral_risks => [ :edit, :update]},  :read => true
    map.permission :delete_behavioral_risks, {:behavioral_risks => [:destroy]},  :read => true
    map.permission :manage_behavioral_risks, {:behavioral_risks => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
  map.project_module :family_histories do |map|
    map.permission :view_family_histories, {:family_histories => [:index]},  :read => true
    map.permission :show_family_histories, {:family_histories => [:show]},  :read => true
    map.permission :create_family_histories, {:family_histories => [:new, :create]},  :read => true
    map.permission :edit_family_histories, {:family_histories => [ :edit, :update]},  :read => true
    map.permission :delete_family_histories, {:family_histories => [:destroy]},  :read => true
    map.permission :manage_family_histories, {:family_histories => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
  map.project_module :immunizations do |map|
    map.permission :view_immunizations, {:immunizations => [:index]},  :read => true
    map.permission :show_immunizations, {:immunizations => [:show]},  :read => true
    map.permission :create_immunizations, {:immunizations => [:new, :create]},  :read => true
    map.permission :edit_immunizations, {:immunizations => [ :edit, :update]},  :read => true
    map.permission :delete_immunizations, {:immunizations => [:destroy]},  :read => true
    map.permission :manage_immunizations, {:immunizations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
  map.project_module :allergies do |map|
    map.permission :view_allergies, {:allergies => [:index]},  :read => true
    map.permission :show_allergies, {:allergies => [:show]},  :read => true
    map.permission :create_allergies, {:allergies => [:new, :create]},  :read => true
    map.permission :edit_allergies, {:allergies => [ :edit, :update]},  :read => true
    map.permission :delete_allergies, {:allergies => [:destroy]},  :read => true
    map.permission :manage_allergies, {:allergies => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
  map.project_module :radiologic_examinations do |map|
    map.permission :view_radiologic_examinations, {:radiologic_examinations => [:index]},  :read => true
    map.permission :show_radiologic_examinations, {:radiologic_examinations => [:show]},  :read => true
    map.permission :create_radiologic_examinations, {:radiologic_examinations => [ :new, :create]},  :read => true
    map.permission :edit_radiologic_examinations, {:radiologic_examinations => [:edit, :update]},  :read => true
    map.permission :delete_radiologic_examinations, {:radiologic_examinations => [:destroy]},  :read => true
    map.permission :manage_radiologic_examinations, {:radiologic_examinations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :laboratory_examinations do |map|
    map.permission :view_laboratory_examinations, {:laboratory_examinations => [:index]},  :read => true
    map.permission :show_laboratory_examinations, {:laboratory_examinations => [:show]},  :read => true
    map.permission :create_laboratory_examinations, {:laboratory_examinations => [ :new, :create]},  :read => true
    map.permission :edit_laboratory_examinations, {:laboratory_examinations => [:edit, :update]},  :read => true
    map.permission :delete_laboratory_examinations, {:laboratory_examinations => [:destroy]},  :read => true
    map.permission :manage_laboratory_examinations, {:laboratory_examinations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
end
