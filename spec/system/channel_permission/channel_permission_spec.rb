require 'rails_helper'

RSpec.describe 'ChannelPermission', feature:true do
  let(:admin) { admin_create }
  let(:channel_name) {Faker::Book.title}

  it "check link and content" do
    Setting['whitelist_ip'] = ''
    login_user(admin.login, admin.password)
    create_channel_spec(channel_name, admin)
    click_on("i", text: "Permissions")
    expect(page).to have_content("Permissions", wait: 10)
    expect(page).to have_content(channel_name, wait:10)
    expect(page).to have_selector(:link_or_button, 'Add Permission')
    expect(page).to have_selector(:link_or_button, 'Back')
  end

end
