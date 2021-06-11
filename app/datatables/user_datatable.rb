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
       "<i class='far fa-lg fa-trash-alt cursor-pointer' id='kt_sweetalert_demo_#{user.id}'></i>
        <script type='text/javascript'>
          $('[id^=kt_sweetalert_demo_]').click(function (e) {
              Swal.fire({
                title: 'Are you sure?',
                text: 'If Delete Permanently checked, You will not be able to recover this User!',
                input: 'checkbox',
                inputPlaceholder: 'Delete Permanently',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Delete',
                cancelButtonText: 'Cancel',
                reverseButtons: true
              }).then(function (result) {
                if (result.isConfirmed) {
                  if(result.value) {
                    $.ajax({
                      url: '/users/#{user.id}/really_destroy',
                      type: 'delete',
                      success: function(response){
                        Swal.fire(
                          'Deleted!',
                          'User has been deleted Permanently.',
                          'success'
                        ).then(function() {
                          window.location.reload();
                        });
                      }
                    })
                  }
                  else {
                    $.ajax({
                      url:'users/#{user.id}',
                      type: 'delete',
                      success: function(response){
                        Swal.fire(
                          'Soft Deleted',
                          'User has been soft deleted.',
                          'success'
                        ).then(function() {
                          window.location.reload();
                        });
                      }
                    })
                  }
                } else if (result.dismiss === 'cancel') {
                  Swal.fire(
                    'Cancelled',
                    'User is not deleted',
                    'error'
                  )
                }
              });
            });
        </script>
        ".html_safe
     end
  end
end
