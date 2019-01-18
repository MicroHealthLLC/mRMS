require "application_system_test_case"

class ChannelsTest < ApplicationSystemTestCase
  test 'creating personal channel' do
    personnal_channel = {
      name: 'Personal Channel',
      option:  Channel::PERSONAL,
      description: 'Exemple of description'
    }
    second_personnal_channel = {
      name: 'second personal Channel',
      option:  Channel::PERSONAL,
      description: 'Exemple of description'
    }
    data_set_params = {
      name: 'Data set name'
    }
    
    sign_in_as_admin
    user_is_signed_in
    i_go_to_new_channel
    i_create_channel(personnal_channel)
    the_channel_is_created(personnal_channel)
    i_go_to_new_channel
    i_create_channel(second_personnal_channel)
    the_channel_is_created(second_personnal_channel)
    i_go_to_edit_channel
    i_update_the_channel_name('New name')
    the_channel_is_updated('New name')
    i_go_to_add_report
    i_add_data_set_to_channel(data_set_params.merge!(channel_name: 'New name'))
    the_data_set_is_created(data_set_params)
    i_go_to_edit_report
    i_edit_data_set_name
    the_data_set_is_updated
    i_go_to_share_report
    i_share_report_with_second_user
    the_report_is_shared
    i_go_to_upload_data
    i_attach_xls_file
    the_xls_file_is_uploaded
  end
  
  
end
