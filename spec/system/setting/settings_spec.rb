require 'rails_helper'


RSpec.describe "Setting", feature: true, js: true do
  let(:admin) { admin_create }

  it "Creates Content Successfully" do
    Setting['whitelist_ip'] = ''
    login_user(admin.login,admin.password)
    visit(settings_path)
    click_link_or_button "Contents"
    content = content_values
    within("#edit_setting_1") do
      #find(:css,"div[id = 'cke_1_contents']").set content[:header]
      execute_script(" CKEDITOR.instances['ckEditorFileManager'].setData('#{content[:header]}');");
      execute_script("$('textarea#header_section').text('#{content[:header]}');")

      execute_script(" CKEDITOR.instances['ckEditorFileManager1'].setData('#{content[:section_1]}');");
      execute_script("$('textarea#section_1').text('#{content[:section_1]}');")

      execute_script(" CKEDITOR.instances['ckEditorFileManager2'].setData('#{content[:section_2]}');");
      execute_script("$('textarea#section_2').text('#{content[:section_2]}');")

      execute_script(" CKEDITOR.instances['ckEditorFileManager3'].setData('#{content[:section_3]}');");
      execute_script("$('textarea#section_3').text('#{content[:section_3]}');")

      execute_script(" CKEDITOR.instances['ckEditorFileManager4'].setData('#{content[:section_4]}');");
      execute_script("$('textarea#section_4').text('#{content[:section_4]}');")

    end
    click_button "Save"
    click_link_or_button "Logout"
    expect(page).to have_current_path(new_user_session_path,wait: 10)
    expect(page).to have_content(content[:header],wait:10)
    expect(page).to have_content(content[:section_1],wait:10)
    expect(page).to have_content(content[:section_2],wait:10)
    expect(page).to have_content(content[:section_3],wait:10)
    expect(page).to have_content(content[:section_4],wait:10)
  end
end
