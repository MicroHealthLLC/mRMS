module ExtendDemographiesHelper
  def url_back
    url = if User.current != User.current_user
            '/profile_record'
          else
            if  User.current.can?(:manage_roles)
              if @extend_demography.user != User.current
                user_path(@extend_demography.user)
              else
                '/users/edit'
              end
            else
              '/profile_record'
            end
          end

    url + '#tabs-extend_demographic'


  end

  def extend_demography_breadcrumb
    object = @extend_demography.object
    case @extend_demography.class.to_s
      when 'AffiliationExtendDemography'
        add_breadcrumb 'Client Profile', '/profile_record'
        add_breadcrumb I18n.t(:affiliations), :affiliations_path
      when 'CaseSupportExtendDemography'
        add_breadcrumb 'Case Records', :cases_path
        if object.case
          add_breadcrumb object.case, object.case
          add_breadcrumb I18n.t(:cases_supports), case_path(object.case) + "#tabs-case_supports"
        else
          add_breadcrumb I18n.t(:cases_supports), :case_supports_path
        end
      when 'ContactExtendDemography'
        add_breadcrumb 'Client Profile', '/profile_record'
        add_breadcrumb I18n.t(:contacts), :contacts_path
      when 'InsuranceExtendDemography'
        add_breadcrumb I18n.t(:insurances), :insurances_path
      when 'OrganizationExtendDemography'
        add_breadcrumb I18n.t(:organizations), :organizations_path
      when 'UserExtendDemography'
        if User.current.can?(:manage_roles)
          if object == User.current
            add_breadcrumb 'Users', '/'
          else
            add_breadcrumb 'Users', '/users'
          end
          add_breadcrumb 'Users', '/users'
        else
          add_breadcrumb 'Client Profile', '/profile_record'
        end
      else
        # nothing to do
    end
    if !User.current.can?(:manage_roles) and object.is_a? User
      add_breadcrumb object, '/profile_record'
    else
      if object == User.current
        add_breadcrumb object, '/users/edit#tabs-extend_demographic'
      else
        add_breadcrumb object, object
      end
    end

  end
end
