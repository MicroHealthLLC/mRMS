require "test_helper"
require 'minitest/retry'
#Minitest::Retry.use!

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers
  include Support::UserSharedContext
  include Support::ChannelsHelper
  include Support::WaitForAjax
  include Support::Select2Helper
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
