RedCarpet::AccessControl.map do |map|
  map.project_module :other_histories do |map|
    map.permission :view_other_histories, {:other_histories => [:index]},  :read => true
    map.permission :show_other_histories, {:other_histories => [:show]},  :read => true
    map.permission :create_other_histories, {:other_histories => [:new, :create]},  :read => true
    map.permission :edit_other_histories, {:other_histories => [ :edit, :update]},  :read => true
    map.permission :delete_other_histories, {:other_histories => [:destroy]},  :read => true
    map.permission :manage_other_histories, {:other_histories => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
  map.project_module :environment_risks do |map|
    map.permission :view_environment_risks, {:environment_risks => [:index]},  :read => true
    map.permission :show_environment_risks, {:environment_risks => [:show]},  :read => true
    map.permission :create_environment_risks, {:environment_risks => [:new, :create]},  :read => true
    map.permission :edit_environment_risks, {:environment_risks => [ :edit, :update]},  :read => true
    map.permission :delete_environment_risks, {:environment_risks => [:destroy]},  :read => true
    map.permission :manage_environment_risks, {:environment_risks => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :socioeconomics do |map|
    map.permission :view_socioeconomics, {:socioeconomics => [:index]},  :read => true
    map.permission :show_socioeconomics, {:socioeconomics => [:show]},  :read => true
    map.permission :create_socioeconomics, {:socioeconomics => [:new, :create]},  :read => true
    map.permission :edit_socioeconomics, {:socioeconomics => [ :edit, :update]},  :read => true
    map.permission :delete_socioeconomics, {:socioeconomics => [:destroy]},  :read => true
    map.permission :manage_socioeconomics, {:socioeconomics => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
end
