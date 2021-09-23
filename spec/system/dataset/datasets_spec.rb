require 'rails_helper'

RSpec.describe "Datasets", feature: true, js: true  do
  let (:admin) {admin_create}
  let (:channel) {channel_create(admin.id)}

  it "is Created Successfully" do
    Setting['whitelist_ip'] = ''
    login_user(admin.login,admin.password)
    visit(channel_path(channel.id))
    click_on("a",text:"Add Data Set")
    within ('#new_report') do
      fill_in "report_name", with: Faker::Name.first_name
      execute_script(" CKEDITOR.instances['report_description'].setData('#{Faker::Name.name}');");
      execute_script("$('textarea#report_description').text('#{Faker::Name.name}');")
    end
    click_button 'Save'
    expect(page).to have_content("New Dashboard")
    expect(page).to have_content("Upload Data")
    expect(page).to have_content("Edit")
    expect(page).to have_content("Delete")
    expect(page).to have_content("Back")
    expect(page).to have_no_content("New Report")
    expect(page).to have_no_content("Dashboards")
    expect(page).to have_no_content("Reports")
  end
end
