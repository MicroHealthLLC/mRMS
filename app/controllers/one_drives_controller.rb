class OneDrivesController < ProtectForgeryApplication

  # before_action  :authenticate_user!

  def index
  end

  def new
    # one_drive = OneDrive::V1.new('6248e237-2454-4f54-a3ed-6355207ad64a', 'http://localhost:3000/one_drives/set_auth', 'files.read.all')
    # byebug
    # one_drive.code_url
    # one_drive.token_url
  end

  def set_auth
    byebug
    render :index
  end
end
