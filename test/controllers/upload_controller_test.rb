require 'test_helper'

class UploadControllerTest < ActionController::TestCase
  test "should get select" do
    get :select
    assert_response :success
  end

  test "should get successful" do
    get :successful
    assert_response :success
  end

end
