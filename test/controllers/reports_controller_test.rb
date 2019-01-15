require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @report = reports(:one)
    @channel = channels(:one)
    @admin = users(:admin)
    sign_in @admin 
  end

  test "should get new" do
    get new_channel_report_url(@channel)
    assert_response :success
  end

  test "should create report" do
    assert_difference('Report.count') do
      post channel_reports_url(@channel), params: { report: { channel_id: @report.channel_id, category_id: @report.category_id, category_type_id: @report.category_type_id, document: @report.document, name: @report.name, user_id: @report.user_id } }
    end

    assert_redirected_to channel_report_url(@channel, Report.last)
  end

  test "should show report" do
    get channel_report_url(@channel, @report)
    assert_response :success
  end

  test "should get edit" do
    get edit_channel_report_url(@channel, @report)
    assert_response :success
  end

  test "should update report" do
    patch channel_report_url(@channel, @report), params: { report: { category_id: @report.category_id, category_type_id: @report.category_type_id, document: @report.document, name: @report.name, user_id: @report.user_id } }
    assert_redirected_to channel_report_url(@channel, @report)
  end

  test "should destroy report" do
    assert_difference('Report.count', -1) do
      delete channel_report_url(@channel, @report)
    end
    assert_redirected_to channel_url(@channel)
  end
end
