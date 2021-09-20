require 'rails_helper'

RSpec.describe "News", feature: true do
  let(:admin) { admin_create }
  it "is Created Successfully" do
    login_user(admin.login,admin.password)
    visit (news_index_path)
    click_button 'New News'
    within '#news_create' do
      fill_in 'news_title', with: Faker::Book.title
      fill_in 'news_summary', with: Faker::Name.name
      fill_in 'news_description',with: Faker::Name.first_name
    end
    click_button 'Save'
  end
end
