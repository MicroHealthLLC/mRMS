require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'
require 'support/wait_for_ajax'
require 'support/user_shared_context'
require 'support/channels_helper'
require 'support/select2_helper'




class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  include Devise::Test::IntegrationHelpers
  include ActionDispatch::TestProcess


  fixtures :all
  ActiveRecord::Migration.check_pending!
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.logger = Rails.logger

  # Add more helper methods to be used by all tests here...
end
