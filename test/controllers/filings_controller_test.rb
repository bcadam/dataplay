require 'test_helper'

class FilingsControllerTest < ActionController::TestCase
  setup do
    @filing = filings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:filings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create filing" do
    assert_difference('Filing.count') do
      post :create, filing: { categories: @filing.categories, id: @filing.id, links: @filing.links, summary: @filing.summary, title: @filing.title, updated: @filing.updated, url: @filing.url }
    end

    assert_redirected_to filing_path(assigns(:filing))
  end

  test "should show filing" do
    get :show, id: @filing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @filing
    assert_response :success
  end

  test "should update filing" do
    patch :update, id: @filing, filing: { categories: @filing.categories, id: @filing.id, links: @filing.links, summary: @filing.summary, title: @filing.title, updated: @filing.updated, url: @filing.url }
    assert_redirected_to filing_path(assigns(:filing))
  end

  test "should destroy filing" do
    assert_difference('Filing.count', -1) do
      delete :destroy, id: @filing
    end

    assert_redirected_to filings_path
  end
end
