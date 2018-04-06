class UserProfilesController < ProtectForgeryApplication
  include ApplicationHelper
  before_action  :authenticate_user!
  before_action :authorize, except: [:occupational_record, :profile_record ]

  def profile_record
    @is_client_doc = true
  end

end
