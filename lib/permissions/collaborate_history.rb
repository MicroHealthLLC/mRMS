#Collaborate
RedCarpet::AccessControl.map do |map|


  map.project_module :news do |map|
    map.permission :view_news, {:news => [:index]}, :read => true
    map.permission :show_news, {:news => [:show]}, :read => true
    map.permission :create_news, {:news => [:new, :create]}, :read => true
    map.permission :edit_news, {:news => [:edit, :update]}, :read => true
    map.permission :delete_news, {:news => [:destroy]}, :read => true
    map.permission :manage_news, {:news => [:index, :show, :new, :create, :edit, :update, :destroy]}, :read => true
  end



end
