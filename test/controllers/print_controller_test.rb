require 'test_helper'

class PrintControllerTest < ActionController::TestCase
  test "should get select" do
    get :select
    assert_response :success
  end

  test "should get sheet" do
    get :sheet
    assert_response :success
  end

end
