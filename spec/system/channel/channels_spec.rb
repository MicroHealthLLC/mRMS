require 'rails_helper'

RSpec.describe 'Channels', feature:true do
  let(:admin) { admin_create }
  let(:channel_name) {Faker::Book.title}

  it "check link and content" do
    Setting['whitelist_ip'] = ''
    login_user(admin.login, admin.password)
    visit (new_channel_path)
    expect(page).to have_selector('strong', :text => 'New Channel', wait: 10)
    expect(page).to have_selector(:link_or_button, 'Save')
  end

  it "check validation fields channel form" do
    Setting['whitelist_ip'] = ''
    login_user(admin.login, admin.password)
    visit (new_channel_path)
    expect(page).to have_selector('strong', :text => 'New Channel', wait: 10)
    expect(page).to have_selector(:link_or_button, 'Save')
    click_button 'Save'
    expect(page).to have_current_path(new_channel_path, wait: 20)
  end

  it "of Group Type is created successfully by Admin" do
    Setting['whitelist_ip'] = ''
    login_user(admin.login, admin.password)
    visit (new_channel_path)
    within('#new_channel_container') do
      execute_script("$('input#channel_user_id').val('#{admin.id}'); ")
      fill_in 'channel_name', with: channel_name
      execute_script("$('input[value=1]').prop('checked', true)")
      execute_script("$('#channelReportSelect').val('fab fa-accessible-icon').trigger('change')")
      execute_script(" CKEDITOR.instances['channel_description'].setData('#{Faker::Name.name}');");
      execute_script("$('textarea#channel_description').text('#{Faker::Name.name}');")
    end
    click_button 'Save'
    expect(page).to have_content(channel_name, wait:10)
    expect(page).to have_content('Permissions')
    expect(page).to have_content('Notifications')
    expect(page).to have_content('Add Data Set')
    expect(page).to have_no_content('Leave Channel')
  end

  it "Edit channel specs" do
    update_channel_name = Faker::Name.name
    Setting['whitelist_ip'] = ''
    login_user(admin.login, admin.password)
    visit (new_channel_path)
    within('#new_channel_container') do
      execute_script("$('input#channel_user_id').val('#{admin.id}'); ")
      fill_in 'channel_name', with: channel_name
      execute_script("$('input[value=1]').prop('checked', true)")
      execute_script("$('#channelReportSelect').val('fab fa-accessible-icon').trigger('change')")
      execute_script(" CKEDITOR.instances['channel_description'].setData('#{Faker::Name.name}');");
      execute_script("$('textarea#channel_description').text('#{Faker::Name.name}');")
    end
    click_button 'Save'
    expect(page).to have_content(channel_name, wait:10)
    expect(page).to have_content('Permissions')
    click_on("i", text:"Edit")
    expect(page).to have_content("Edit Channel", wait: 10)
    within('#new_channel_container') do
      execute_script("$('input#channel_user_id').val('#{admin.id}'); ")
      fill_in 'channel_name', with: update_channel_name
    end
    click_button 'Save'
    expect(page).to have_content(update_channel_name, wait:10)
  end
end
