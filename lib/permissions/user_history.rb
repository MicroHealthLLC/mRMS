RedCarpet::AccessControl.map do |map|
  map.project_module :daily_livings do |map|
    map.permission :view_daily_livings, {:daily_livings => [:index]},  :read => true
    map.permission :show_daily_livings, {:daily_livings => [:show]},  :read => true
    map.permission :create_daily_livings, {:daily_livings => [:new, :create]},  :read => true
    map.permission :edit_daily_livings, {:daily_livings => [:edit, :update]},  :read => true
    map.permission :delete_daily_livings, {:daily_livings => [:destroy]},  :read => true
    map.permission :manage_daily_livings, {:daily_livings => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :financials do |map|
    map.permission :view_financials, {:financials => [:index]},  :read => true
    map.permission :show_financials, {:financials => [:show]},  :read => true
    map.permission :create_financials, {:financials => [:new, :create]},  :read => true
    map.permission :edit_financials, {:financials => [:edit, :update]},  :read => true
    map.permission :delete_financials, {:financials => [:destroy]},  :read => true
    map.permission :manage_financials, {:financials => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :transportations do |map|
    map.permission :view_transportations, {:transportations => [:index]},  :read => true
    map.permission :show_transportations, {:transportations => [:show]},  :read => true
    map.permission :create_transportations, {:transportations => [:new, :create]},  :read => true
    map.permission :edit_transportations, {:transportations => [:edit, :update]},  :read => true
    map.permission :delete_transportations, {:transportations => [:destroy]},  :read => true
    map.permission :manage_transportations, {:transportations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :legals do |map|
    map.permission :view_legals, {:legals => [:index]},  :read => true
    map.permission :show_legals, {:legals => [:show]},  :read => true
    map.permission :create_legals, {:legals => [:new, :create]},  :read => true
    map.permission :edit_legals, {:legals => [:edit, :update]},  :read => true
    map.permission :delete_legals, {:legals => [:destroy]},  :read => true
    map.permission :manage_legals, {:legals => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
  map.project_module :housings do |map|
    map.permission :view_housings, {:housings => [:index]},  :read => true
    map.permission :show_housings, {:housings => [:show]},  :read => true
    map.permission :create_housings, {:housings => [:new, :create]},  :read => true
    map.permission :edit_housings, {:housings => [ :edit, :update]},  :read => true
    map.permission :delete_housings, {:housings => [:destroy]},  :read => true
    map.permission :manage_housings, {:housings => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
end
