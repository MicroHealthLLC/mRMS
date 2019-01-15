require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @report = reports(:one)
    @report_b = reports(:two)
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

  test 'should upload xls file' do
    post upload_document_channel_report_url(@channel, @report_b), params: {report: {document: fixture_file_upload('files/file_a.xlsx', 'text/xlsx')}, format: 'js'}
    @report_b.reload
    assert_equal true , @report_b.document.file.present?
  end

  test 'should share report' do
    personal_channel = channels(:personal)
    report_with_personal_channel = reports(:report_with_personal_channel)
    second_user = users(:second_user)
    post share_report_channel_report_url(personal_channel, report_with_personal_channel), params: {users: [second_user.id]}
    report_with_personal_channel.reload
    assert_equal true , report_with_personal_channel.shared_reports.pluck(:user_id).include?(second_user.id)
    assert_redirected_to channel_report_url(report_with_personal_channel, report_with_personal_channel)
  end

  test 'should create pivot table' do
    report = @channel.reports.last
    save_pivot_table_params = {
      report_id: report.id,
      user_id: report.user_id,
      name: 'name',
      content: {}
    }
    assert_difference('SavePivotTable.count') do
      post save_pivottable_channel_report_url(@channel, report), params: {save_pivot_table: save_pivot_table_params}
    end
    assert_redirected_to channel_report_url(@channel, report, query_id: SavePivotTable.last.id)
  end

  test 'should update pivot table' do
    save_pivot_table = SavePivotTable.last
    report = save_pivot_table.report
    save_pivot_table_params = {
      report_id: save_pivot_table.report_id,
      user_id: save_pivot_table.user_id,
      name: 'new name',
      content: {}
    }
    post save_pivottable_channel_report_url(@channel, report), params: {query_id: save_pivot_table.id ,save_pivot_table: save_pivot_table_params}

    assert_redirected_to channel_report_url(@channel, report, query_id: save_pivot_table.id)
    save_pivot_table.reload
    assert_equal 'new name', save_pivot_table.name
  end

  test 'should delete pivot table' do
    save_pivot_table = SavePivotTable.last
    report = save_pivot_table.report
    
    assert_difference('SavePivotTable.count', -1) do
      delete delete_pivottable_channel_report_url(@channel, report), params: {query_id: save_pivot_table.id}
    end

    assert_redirected_to channel_report_url(@channel, report)
  end

  test 'should delete all pivot table' do
    save_pivot_table = SavePivotTable.last
    report = save_pivot_table.report
    assert_difference('SavePivotTable.count', 0) do
      delete delete_pivottable_channel_report_url(@channel, report), params: {delete_all: true}
    end
    assert_redirected_to channel_report_url(@channel, report)
  end
end
