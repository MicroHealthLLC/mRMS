require 'test_helper'

class ChannelPermissionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get channel_permission_index_url
    assert_response :success
  end

  test "should get new" do
    get channel_permission_new_url
    assert_response :success
  end

  test "should get destroy" do
    get channel_permission_destroy_url
    assert_response :success
  end

end
