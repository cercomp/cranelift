# encoding: utf-8
require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "get new" do
    get :new
    assert_response :success
  end

  test "login" do
    post(:create, {:login => 'user1', :password => 'user1'})
    assert_redirected_to root_path
    assert_equal users(:one).id, session[:user_id] # ?
    assert_equal 'Acesso confirmado', flash[:notice]
  end

  test "not login" do
    post(:create, {:login => 'unknowuser', :password => '?'})
    assert_nil assigns['user']
  end

  test "logout" do
    delete(:destroy, nil, {:user_id => users(:one).id})
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end
end
