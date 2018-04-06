RedCarpet::AccessControl.map do |map|

  # user profile

  
  map.project_module :identifications do |map|
    map.permission :view_identifications, {:identifications => [:index]},  :read => true
    map.permission :show_identifications, {:identifications => [:show]},  :read => true
    map.permission :create_identifications, {:identifications => [ :new, :create]},  :read => true
    map.permission :edit_identifications, {:identifications => [:edit, :update]},  :read => true
    map.permission :delete_identifications, {:identifications => [:destroy]},  :read => true
    map.permission :manage_identifications, {:identifications => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :reports do |map|
    map.permission :view_reports, {:reports => [:index]},  :read => true
    map.permission :show_reports, {:reports => [:show]},  :read => true
    map.permission :create_reports, {:reports => [ :new, :create]},  :read => true
    map.permission :edit_reports, {:reports => [:edit, :update]},  :read => true
    map.permission :delete_reports, {:reports => [:destroy]},  :read => true
    map.permission :manage_reports, {:reports => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :channels do |map|
    map.permission :view_channels, {:channels => [:index]},  :read => true
    map.permission :show_channels, {:channels => [:show]},  :read => true
    map.permission :create_channels, {:channels => [ :new, :create]},  :read => true
    map.permission :edit_channels, {:channels => [:edit, :update]},  :read => true
    map.permission :delete_channels, {:channels => [:destroy]},  :read => true
    map.permission :manage_channels, {:channels => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

end
