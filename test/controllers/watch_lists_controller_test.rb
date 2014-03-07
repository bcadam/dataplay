require 'test_helper'

class WatchListsControllerTest < ActionController::TestCase
  setup do
    @watch_list = watch_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:watch_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create watch_list" do
    assert_difference('WatchList.count') do
      post :create, watch_list: { name: @watch_list.name }
    end

    assert_redirected_to watch_list_path(assigns(:watch_list))
  end

  test "should show watch_list" do
    get :show, id: @watch_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @watch_list
    assert_response :success
  end

  test "should update watch_list" do
    patch :update, id: @watch_list, watch_list: { name: @watch_list.name }
    assert_redirected_to watch_list_path(assigns(:watch_list))
  end

  test "should destroy watch_list" do
    assert_difference('WatchList.count', -1) do
      delete :destroy, id: @watch_list
    end

    assert_redirected_to watch_lists_path
  end
end
