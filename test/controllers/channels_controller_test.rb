require 'test_helper'

class ChannelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @channel = channels(:one)
    sign_in @admin 
  end

  test "should get new" do
    get new_channel_url
    assert_response :success
  end

  test "should create channel" do
    assert_difference('Channel.count') do
      post channels_url, params: { channel: { is_public: true, name: 'channel name', user_id: @admin.id, option: Channel::PUBLIC  } }
    end

    assert_redirected_to channel_url(Channel.last)
  end

  test "should show channel" do
    get channel_url(@channel)
    assert_response :success
  end

  test "should get edit" do
    get edit_channel_url(@channel)
    assert_response :success
  end

  test "should update channel" do
    patch channel_url(@channel), params: { channel: { is_public: @channel.is_public, name: 'new channel name', user_id: @channel.user_id, option: Channel::PUBLIC } }
    assert_redirected_to channel_url(@channel)
    @channel.reload
    assert_equal 'new channel name', @channel.name 
  end

  test "should destroy channel" do
    assert_difference('Channel.count', -1) do
      delete channel_url(@channel)
    end
    assert_redirected_to root_path
  end
end
