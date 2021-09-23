
def user_create
  User.create(login: Faker::Name.name,email: Faker::Internet.email,password:Faker::Internet.password(mix_case: true), state: "active")
end

def admin_create
  User.create(login: Faker::Name.name,email: Faker::Internet.free_email,password:Faker::Internet.password(mix_case: true), state: "active", admin: true)
end

def content_values
  {header:Faker::Name.name,section_1:Faker::Name.name, section_2:Faker::Name.name,section_3:Faker::Name.name,section_4:Faker::Name.name}
end

def channel_create(user_id)
  Channel.create(user_id: user_id, name: Faker::Name.name, option: 2, icon: "fab fa-500px",description:"This is the real topic")
end

def login_user(login_name, password)
  visit '/users/sign_in'
  within("#login-form") do
    fill_in 'user_login', with: login_name
    fill_in 'user_password', with: password
  end
  click_button 'Sign in'
end

def fill_in_ckeditor(locator, opts)
  content = opts
  page.execute_script(" $(#'#{locator}').html('#{content}') ")
end

def create_channel_spec(channel_name, admin)
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
end
