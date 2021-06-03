class OneDrivesController < ProtectForgeryApplication

  before_action  :authenticate_user!

  def index
    if current_user.onedrive_access_token.present?
      @drives = OneDriveService.new(current_user.onedrive_access_token).call rescue nil
    end
  end
end
