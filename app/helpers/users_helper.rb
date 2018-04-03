module UsersHelper
  def password_min
    User.password_length.min
  end

  def password_max
    User.password_length.max
  end

  def user_admin_show_page
    tabs = [
        {:name => 'core_demographic', :partial => 'users/shared/core_demography', :label => :core_demography},
        {:name => 'extend_demographic', :partial => 'users/shared/extend_demography', :label => :extend_demography}

    ]

    tabs << {:name => 'user_basic', :partial => 'users/shared/user_basic_information', :label => :user_basic_information}
    tabs << {:name => 'password', :partial => 'users/shared/password', :label => :password}
    # tabs << {:name => 'organization', :partial => 'users/shared/job_detail', :label => :organization}

    # tabs << {:name => 'signature', :partial => 'users/shared/signature', :label => :signature} if User.current.can?(:manage_roles, :view_jsignatures, :manage_jsignatures)
    tabs << {:name => 'attachment', :partial => 'users/shared/attachment', :label => :attachment}

    tabs
  end

end
