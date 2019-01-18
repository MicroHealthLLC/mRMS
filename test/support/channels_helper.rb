module Support
  module ChannelsHelper

    def i_go_to_new_channel
      visit new_channel_url
    end

    def i_create_channel(channel_params)
      i_fill_channel_form(channel_params)
    end

    def the_channel_is_created(channel_params)
      assert_selector "#flash_notice", text: "Channel was successfully created."
    end

    def the_channel_is_updated(new_name)
       assert_selector "p", text: new_name
       assert_selector "#flash_notice", text: "Channel was successfully updated."
    end

    def i_update_the_channel_name(name)
        fill_in('channel[name]', with: name)
        find_button(value: 'Save').click
        wait_for_ajax
    end

    def i_go_to_edit_channel
        click_on 'Edit'
        wait_for_ajax
    end

    def i_fill_channel_form(params)
      within("form") do
       fill_in('channel[name]', with: params[:name])
       choose('channel[option]', option: params[:option])
       find_button(value: 'Save').click
      end
      wait_for_ajax
    end

    def i_fill_data_set_form(params)
        within("form") do
            fill_in('report[name]', with: params[:name])
            select2(params[:channel_name], from: 'report_channel_id') if params[:channel_name]
            find_button(value: 'Save').click
        end
        wait_for_ajax
    end

    def i_add_data_set_to_channel data_set_params
        i_fill_data_set_form(data_set_params)
    end

    def i_go_to_add_report
        click_on 'Add Data set'
        wait_for_ajax
    end
    
    def the_data_set_is_created data_set_params
        assert_selector 'p', text:  data_set_params[:name]
        assert_selector "#flash_notice", 'Data set was successfully created.'
    end

    def i_go_to_share_report
        click_on 'Share Report'
        wait_for_ajax
    end
    
    def i_share_report_with_second_user
        user = users(:second_user)
        i_share_report_with_user user
    end

    def i_share_report_with_user user
        find(:css, "#users_[value='#{user.id}']").set(true)
        click_on 'Save'
    end

    def the_report_is_shared
        assert_selector "#flash_notice", 'Share Report updated successfully.'
    end

    def i_go_to_upload_data
        click_on 'Upload Data'        
    end

    def i_attach_xls_file
       find("input[name='report[document]']", visible: false).set("#{Rails.root}/test/fixtures/files/file_a.xlsx")
       wait_for_ajax
    end

    def the_xls_file_is_uploaded
        assert_selector 'p', text: 'file_a.xlsx'
    end

    

    def i_go_to_edit_report
        click_on 'Edit'
        wait_for_ajax
    end
    
    def i_edit_data_set_name
        within("form") do
            fill_in('report[name]', with: 'Updated Report Name')
            find_button(value: 'Save').click
        end
        wait_for_ajax
    end
    def the_data_set_is_updated
        assert_selector "#flash_notice", 'Data set was successfully updated.'
    end
  end
end       