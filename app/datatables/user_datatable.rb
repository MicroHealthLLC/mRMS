class UserDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      User.id
      User.login
      User.email
      CoreDemographic.first_name
      CoreDemographic.middle_name
      CoreDemographic.last_name
      CoreDemographic.birth_date
      Role.name
      User.state
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      User.id
      User.login
      User.email
      CoreDemographic.first_name
      CoreDemographic.middle_name
      CoreDemographic.last_name
      CoreDemographic.birth_date
      Role.name
      User.state
    }
  end

  private

  def data
    records.map do |user|
      [
          user.uuid ,
          link_user(user),
          user.email,

          user.first_name,
          user.last_name,

          @view.format_date(user.birthday),
          user.role.to_s,
          user.state,

          user.deleted? ?   @view.restore_user_link(user, 'data-turbolinks'=> false) :  @view.delete_link(user, 'data-turbolinks'=> false),
          user.locked_at? ?   @view.unlock_user_link(user, 'data-turbolinks'=> false) :  @view.lock_user_link(user, 'data-turbolinks'=> false),
          @view.change_password_user_link(user, 'data-turbolinks'=> false)
      ]
    end
  end

  def get_raw_records
    User.unscoped.include_enumerations.where.not(id: User.current.id)
  end

  def link_user user
    user.deleted? ? user.login : @view.link_to(user.login, user, 'data-turbolinks'=> false)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
