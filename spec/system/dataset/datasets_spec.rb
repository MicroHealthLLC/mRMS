require 'rails_helper'

RSpec.describe "Datasets", feature: true, js: true  do
  let (:admin) {admin_create}
  let (:channel_name) {Faker::Book.title}
  let (:new_channel_name) {Faker::Book.title}
  it "is Created Successfully" do
    Setting['whitelist_ip'] = ''
    login_user(admin.login,admin.password)
    create_channel_spec(channel_name,admin)
    create_dataset_spec
  end

  it "gets deleted Sucessfully" do
    Setting['whitelist_ip'] = ''
    login_user(admin.login,admin.password)
    create_channel_spec(channel_name,admin)
    create_dataset_spec
    accept_confirm do
      click_link_or_button "Delete"
    end
    expect(page).to have_current_path(channel_path(admin.channels.find_by(name:channel_name).id))
  end

  it "gets updated Sucessfully" do
    new_channel_name = Faker::Name.name
    Setting['whitelist_ip'] = ''
    login_user(admin.login,admin.password)
    create_channel_spec(channel_name,admin)
    create_dataset_spec
    click_link_or_button "Edit"
    within('.form-horizontal') do
      fill_in "report_name", with: new_channel_name
    end
    click_button "Save"
    expect(page).to have_content(new_channel_name)
  end

  it "uploads file Successfully" do
    new_channel_name = Faker::Name.name
    Setting['whitelist_ip'] = ''
    login_user(admin.login,admin.password)
    create_channel_spec(channel_name,admin)
    create_dataset_with_file_spec
    expect(page).to have_no_content("New Report")
    expect(page).to have_no_content("Dashboards")
    expect(page).to have_no_content("Reports")
  end
end
