class EmployeeDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
        User.id
      CoreDemographic.first_name
      CoreDemographic.middle_name
      CoreDemographic.last_name
      CoreDemographic.gender
      CoreDemographic.birth_date
      User.state
      Organization.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      User.id
      CoreDemographic.first_name
      CoreDemographic.middle_name
      CoreDemographic.last_name
      CoreDemographic.gender
      CoreDemographic.birth_date
      User.state
      Organization.name
    }
  end

  private

  def data
    records.map do |user|
      [
          @view.link_to( user.uuid,  @view.log_in_employee_path(user), 'data-turbolinks'=> false) ,
          @view.link_to( user.first_name.to_s,  @view.log_in_employee_path(user), 'data-turbolinks'=> false) ,
          user.middle_name ,

          user.last_name,
          user.gender.to_s,
          user.email ,

          @view.format_date(user.birthday) ,
          user.organization.to_s,
          user.state

      ]
    end
  end

  def get_raw_records
    scope = User.employees.include_enumerations
        # .includes(:job_detail=> [:organization]).
        # references(:job_detail=> [:organization])

    case @options[:status_type]
      when 'active' then scope= scope.where(state: true)
      when 'inactive' then scope = scope.where(state: false)
      when 'all' then scope
      else
        scope = scope.where(state: true)
    end

    return scope
    # if User.current_user.admin?
    #   scope
    # else
    #   org = User.current_user.organization
    #   co = (CaseOrganization.where(organization_id: org.try(:id)).or(CaseOrganization.where(case_id: User.current_user.cases.pluck(:id))
    #       ).pluck(:organization_id) + [ org.try(:id) ]).uniq.compact
    #
    #
    #   scope = scope.includes(:case_organizations, :job_detail).
    #       references(:case_organizations, :job_detail)
    #
    #   scope.where(case_organizations: {organization_id: co }).or( scope.merge(JobDetail.where(organization_id: co) ))
    # end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
