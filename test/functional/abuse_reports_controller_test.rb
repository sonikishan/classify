require 'test_helper'

class AbuseReportsControllerTest < ActionController::TestCase
  setup do
    @abuse_report = abuse_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abuse_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abuse_report" do
    assert_difference('AbuseReport.count') do
      post :create, abuse_report: { message: @abuse_report.message }
    end

    assert_redirected_to abuse_report_path(assigns(:abuse_report))
  end

  test "should show abuse_report" do
    get :show, id: @abuse_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @abuse_report
    assert_response :success
  end

  test "should update abuse_report" do
    put :update, id: @abuse_report, abuse_report: { message: @abuse_report.message }
    assert_redirected_to abuse_report_path(assigns(:abuse_report))
  end

  test "should destroy abuse_report" do
    assert_difference('AbuseReport.count', -1) do
      delete :destroy, id: @abuse_report
    end

    assert_redirected_to abuse_reports_path
  end
end
