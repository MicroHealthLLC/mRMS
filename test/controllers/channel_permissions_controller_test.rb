require 'test_helper'

class ChannelPermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @channel = channels(:one)
    sign_in @admin 
  end

  test "should get index" do
    get channel_permissions
    assert_response :success
  end

  test "should get new" do
    get new_channel_permissions_url
    assert_response :success
  end

  test "should get destroy" do
   
  end

end
