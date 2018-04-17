class CallbacksController < Devise::OmniauthCallbacksController
  def github
    check_omniauth_auth
  end

  def office365
    check_omniauth_auth
  end

  def facebook
    check_omniauth_auth
  end

  def twitter
    check_omniauth_auth
  end

  def google_oauth2
    check_omniauth_auth
  end

  private

  def check_omniauth_auth
    if User.user_deleted?(request.env["omniauth.auth"])
      flash[:error] = 'Cannot login: Check with admin'
      redirect_to root_path
    elsif User.get_user(request.env["omniauth.auth"]).nil? and EnabledModule.active.where(name: 'user_subscription').blank?
      flash[:error] = 'Social Sign up is not enabled'
      redirect_to root_path
    else
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
    end
  end
end
