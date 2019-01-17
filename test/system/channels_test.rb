require "application_system_test_case"

class ChannelsTest < ApplicationSystemTestCase
  test 'creating personal channel' do
    sign_in_as_admin
    user_is_signed_in
    i_go_to_new_channel
    i_create_personal_channel
    the_channel_is_created
    i_go_to_edit_channel
    i_update_the_personal_channel
    the_channel_is_updated
    i_go_to_add_report
    i_add_data_set_to_personal_channel
    the_data_set_is_created
    i_go_to_edit_report
    i_edit_report_name
    the_report_is_updated
    i_go_to_share_report
    i_share_report_with_second_user
    the_report_is_shared
    i_go_to_upload_data
    i_attach_xls_file
  end
  
  
end
