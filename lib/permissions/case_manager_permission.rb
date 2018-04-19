RedCarpet::AccessControl.map do |map|

  map.project_module :employee do |map|
    map.permission :manage_roles, {
        :employees => [:index],
        :document => [:all_files, :index, :new, :show, :create, :edit, :update, :destroy],
        :news => [:index, :show, :new, :create, :edit, :update, :destroy],
        :channels => [:index, :show, :new, :create, :edit, :update, :destroy],
        :reports => [:index, :show, :new, :create, :edit, :update, :destroy]
    },  :read => true
  end
end
