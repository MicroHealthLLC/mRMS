require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  test "should not save channel without name or option" do

    admin = users(:admin)
    channel = Channel.new(user_id: admin.id)
    assert_not channel.save, "Saved the channel name or option"
  end
end
