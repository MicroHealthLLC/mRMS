module WelcomeHelper
  def check_root?
    request.env['PATH_INFO'] == root_path
  end

  def check_dashboard(dashboard)
     dashboard.class.name == "Dashboard"
  end
end
