require 'test_helper'

class DataDashboardsControllerTest < ActionController::TestCase
  setup do
    @data_dashboard = data_dashboards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_dashboards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_dashboard" do
    assert_difference('DataDashboard.count') do
      post :create, data_dashboard: { budget: @data_dashboard.budget, calls: @data_dashboard.calls, clicks: @data_dashboard.clicks, computers: @data_dashboard.computers, cost: @data_dashboard.cost, dashboard_id: @data_dashboard.dashboard_id, searches: @data_dashboard.searches, smartphones: @data_dashboard.smartphones, tablets: @data_dashboard.tablets }
    end

    assert_redirected_to data_dashboard_path(assigns(:data_dashboard))
  end

  test "should show data_dashboard" do
    get :show, id: @data_dashboard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @data_dashboard
    assert_response :success
  end

  test "should update data_dashboard" do
    patch :update, id: @data_dashboard, data_dashboard: { budget: @data_dashboard.budget, calls: @data_dashboard.calls, clicks: @data_dashboard.clicks, computers: @data_dashboard.computers, cost: @data_dashboard.cost, dashboard_id: @data_dashboard.dashboard_id, searches: @data_dashboard.searches, smartphones: @data_dashboard.smartphones, tablets: @data_dashboard.tablets }
    assert_redirected_to data_dashboard_path(assigns(:data_dashboard))
  end

  test "should destroy data_dashboard" do
    assert_difference('DataDashboard.count', -1) do
      delete :destroy, id: @data_dashboard
    end

    assert_redirected_to data_dashboards_path
  end
end
