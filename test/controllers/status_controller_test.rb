require 'test_helper'

class StatusControllerTest < ActionController::TestCase
  test "should get checkout" do
    get :checkout
    assert_response :success
  end

  test "should get checkin" do
    get :checkin
    assert_response :success
  end

end
