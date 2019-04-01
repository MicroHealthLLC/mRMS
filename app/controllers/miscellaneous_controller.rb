class MiscellaneousController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:register, :forgot_password]

  def login
    redirect_to new_user_session_path
    @simulate_no_user = true
  end

  def register
    redirect_to new_user_registration_path
    @simulate_no_user = true
  end

  def forgot_password
    redirect_to new_user_password_path
    @simulate_no_user = true
  end

  def locked_screen
    @simulate_no_user = true
    @lock_screen = true
  end

  def blank_page
  end
end
