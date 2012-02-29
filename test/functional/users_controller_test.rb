require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "new user form" do
    get :new
    assert_response :success
    assert assigns['user']
  end

  test "create user" do
    assert false, 'write this test'
  end
end
