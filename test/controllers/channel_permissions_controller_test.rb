require 'test_helper'

class ChannelPermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @channel = channels(:one)
    @viewer_editor_permissions = channel_permissions(:viewer_editor_permissions)
    sign_in @admin 
    @viewer_rights = {can_view: 1, can_edit: 0, can_add_report: 0, can_view_report: 0, can_delete_report: 0, can_add_users: 0, can_download: 0}
  end

  test "should get channel permissions" do
    get channel_channel_permissions_url(@channel)
    assert_response :success
  end

  test "should add permissions to signed in user as viewer of channel" do
    assert_difference('@channel.channel_permissions.count') do
      post channel_channel_permissions_url(@channel), params: {
         channel_permission: { user_id: @admin.id }.merge(@viewer_rights)
         }
    end
    @channel.reload
    channel_permisison = @channel.channel_permissions.last
    assert_equal true, channel_permisison.can_view? 
  end

  test "should update exist permissions by removing edit right" do
    patch channel_channel_permission_url(@channel, @viewer_editor_permissions), params: {
      channel_permission: @viewer_rights
      }
    @viewer_editor_permissions.reload
    assert_equal true, @viewer_editor_permissions.can_view? 
    assert_equal false, @viewer_editor_permissions.can_edit?   
  end

  test "should destroy channel permission" do
    assert_difference('@channel.channel_permissions.count', -1) do
      delete channel_channel_permission_url(@channel, @viewer_editor_permissions)
    end
    assert_redirected_to root_path
  end  


end
