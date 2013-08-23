require 'test_helper'

class ViewCountsControllerTest < ActionController::TestCase
  setup do
    @view_count = view_counts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:view_counts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create view_count" do
    assert_difference('ViewCount.count') do
      post :create, view_count: { amount: @view_count.amount }
    end

    assert_redirected_to view_count_path(assigns(:view_count))
  end

  test "should show view_count" do
    get :show, id: @view_count
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @view_count
    assert_response :success
  end

  test "should update view_count" do
    put :update, id: @view_count, view_count: { amount: @view_count.amount }
    assert_redirected_to view_count_path(assigns(:view_count))
  end

  test "should destroy view_count" do
    assert_difference('ViewCount.count', -1) do
      delete :destroy, id: @view_count
    end

    assert_redirected_to view_counts_path
  end
end
