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

end
