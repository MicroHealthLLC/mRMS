module UsersHelper
  def password_min
    Devise.password_length.min
  end

  def password_max
    Devise.password_length.max
  end

  def user_admin_show_page
    tabs = [
        {:name => 'core_demographic', :partial => 'users/shared/core_demography', :label => :core_demography},
        {:name => 'user_basic', :partial => 'users/shared/user_basic_information', :label => :user_basic_information},
        {:name => 'password', :partial => 'users/shared/password', :label => :password}
     ]
    tabs
  end

end
