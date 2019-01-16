module Support
  module ChannelsHelper

    def i_go_to_new_channel
      visit new_channel_url
    end
    def i_create_personal_channel
        personnal_channel = {
            name: 'Personal Channel',
            option:  Channel::PERSONAL,
            description: 'Exemple of description'
        }
             
        i_fill_form(personnal_channel)
    end

    def the_channel_is_created
      assert_selector "#flash_notice", text: "Channel was successfully created."
    end

    def the_channel_is_updated
       assert_selector "#flash_notice", text: "Channel was successfully updated."
    end

    def i_update_the_personal_channel
        
        fill_in('channel[name]', with: 'Updated personal channel')
        find_button(value: 'Save').click
        wait_for_ajax
    end

    def i_go_to_edit_channel
        click_on 'Edit'
        wait_for_ajax
    end

    def i_fill_form(params)
      within("form") do
       fill_in('channel[name]', with: params[:name])
       choose('channel[option]', option: params[:option])
       find_button(value: 'Save').click
      end
      wait_for_ajax
    end

    def i_add_data_set_to_personal_channel
        within("form") do
            fill_in('report[name]', with: 'Report Name')
            find_button(value: 'Save').click
        end
        wait_for_ajax
    end

    def i_go_to_add_report
        click_on 'Add Data set'
        wait_for_ajax
    end
    def the_data_set_is_created
        assert_selector "#flash_notice", 'Data set was successfully created.'
    end

    def i_go_to_share_report
        click_on 'Share Report'
        wait_for_ajax
    end

    def i_share_report_with_admin
    end

    def the_report_is_shared
        assert_selector "#flash_notice", 'Share Report updated successfully.'
    end

    def i_go_to_edit_report
        click_on 'Edit'
        wait_for_ajax
    end
    
    def i_edit_report_name
        within("form") do
            fill_in('report[name]', with: 'Updated Report Name')
            find_button(value: 'Save').click
        end
        wait_for_ajax
    end
    def the_report_is_updated
        assert_selector "#flash_notice", 'Data set was successfully updated.'
    end
  end
end       