module WelcomeHelper
  def check_root?
    request.env['PATH_INFO'] == root_path
  end
end
