require 'rails_helper'

RSpec.describe "Users", feature: true do
  let (:user) { user_create }

  it "sign in" do
    Setting['whitelist_ip'] = ''
    login_user(user.login, user.password)
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Signed in successfully', wait: 10)
    expect(page).to have_content('MCMS', wait: 10)
    expect(page).to have_content('Dashboards', wait: 10)
    expect(page).to have_content('Reports', wait: 10)
  end
end

