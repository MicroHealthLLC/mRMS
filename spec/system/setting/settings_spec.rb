require 'rails_helper'

Spec.describe "Setting", feature: true do
  let(:admin) { admin_create }
  it "Creates Content Successfully" do
    Setting['whitelist_ip'] = ''
    login_user(admin.login,admin.password)
    visit(settings_path)
    click_button "Contents"
    content = contents_values
    within(".form-horizontal") do
      fill_in 'header_section', with: content.header
      fill_in 'section_1', with: content.section_1
      fill_in 'section_2', with: content.section_2
      fill_in 'section_3', with: content.section_3
      fill_in 'section_4', with: content.section_4
    end
    click_button "Save"
    click_button "Logout"
    expect(page).to have_curre()
  end
end
