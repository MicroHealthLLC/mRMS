class UserDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      User.id
      User.login
      User.email
      CoreDemographic.first_name
      CoreDemographic.last_name
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
      CoreDemographic.last_name
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
          user.state.humanize,

          delete_user(user),
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
  def delete_user user
     user.deleted? ?   @view.restore_user_link(user, 'data-turbolinks'=> false) :  @view.delete_link(user, 'data-turbolinks'=> false)
     if user.deleted?
        @view.restore_user_link(user, 'data-turbolinks' => false)
     else
       "<i class='far fa-lg fa-trash-alt kt_sweetalert_demo_9 cursor-pointer'></i>
        <script type='text/javascript'>
          $('.kt_sweetalert_demo_9').click(function (e) {
              Swal.fire({
                title: 'Are you sure?',
                text: '',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Delete Permanently!',
                cancelButtonText: 'Soft Delete!',
                reverseButtons: true
              }).then(function (result) {
                if (result.value) {
                  $.ajax({
                    url: '/users/#{user.id}/really_destroy',
                    type: 'delete',
                    success: function(response){
                      Swal.fire(
                        'Deleted!',
                        'User has been deleted Permanently.',
                        'success'
                      )
                      window.location.reload();
                    }
                  })
                  // result.dismiss can be 'cancel', 'overlay',
                  // 'close', and 'timer'
                } else if (result.dismiss === 'cancel') {
                  $.ajax({
                    url:'users/#{user.id}',
                    type: 'delete',
                    success: function(response){
                      Swal.fire(
                        'Soft Deleted',
                        'User has been soft deleted:)',
                        'success'
                      )
                      window.location.reload();
                    }
                  })
                }
              });
            });
        </script>
        ".html_safe
     end
  end
end
