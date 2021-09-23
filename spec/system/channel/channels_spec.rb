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
    create_channel_spec(channel_name, admin)
    expect(page).to have_content('Notifications')
    expect(page).to have_content('Add Data Set')
    expect(page).to have_no_content('Leave Channel')
  end

  it "Edit channel specs" do
    update_channel_name = Faker::Name.name
    Setting['whitelist_ip'] = ''
    login_user(admin.login, admin.password)
    create_channel_spec(channel_name, admin)
    click_on("i", text: "Edit")
    expect(page).to have_content("Edit Channel", wait: 10)
    within('#new_channel_container') do
      execute_script("$('input#channel_user_id').val('#{admin.id}'); ")
      fill_in 'channel_name', with: update_channel_name
    end
    click_button 'Save'
    expect(page).to have_content(update_channel_name, wait:10)
  end

  it "delete channel specs" do
    update_channel_name = Faker::Name.name
    Setting['whitelist_ip'] = ''
    login_user(admin.login, admin.password)
    create_channel_spec(channel_name, admin)
    accept_confirm do
      click_link_or_button "Delete"
    end
    page.evaluate_script('window.confirm = function() { return true; }')
    expect(page).to have_current_path(root_path, wait: 10)
  end
end
