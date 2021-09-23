require 'rails_helper'

RSpec.describe "Enumerations", type: :system, js: true do
  let(:admin) { admin_create }

  describe "Enumerations spec" do
    it "check links and content" do
      Setting['whitelist_ip'] = ''
      login_user(admin.login,admin.password)
      visit (enumerations_path)
      expect(page).to have_content("ENUMERATIONS")
      expect(page).to have_content("Role")
      expect(page).to have_content("Organization")
      expect(page).to have_content("Report Category")
    end

    it "create enumerations role" do
      Setting['whitelist_ip'] = ''
      login_user(admin.login,admin.password)
      visit (enumerations_path)
      expect(page).to have_content("ENUMERATIONS")
      expect(page).to have_content("Role")
      find('a[href="/enumerations/new?type=ReportEnum"]').click
      expect(page).to have_content("New Report Category")
    end
  end
end
