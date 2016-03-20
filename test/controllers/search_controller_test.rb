require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get search" do
    get :welcome
    assert_response :success
  end

  test "should get post search" do
    post :new
    assert_response :success
    assert_not_nil assigns(:search)
  end

  test "should get search by ID" do
    get( :view, {'id' => 1}, :format => :json)
    assert_response :success

  end


end
