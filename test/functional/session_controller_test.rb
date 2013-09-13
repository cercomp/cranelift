# encoding: utf-8
require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "get new" do
    get :login
    assert_response :success
  end

  test "login" do
    post(:create_session, {:login => 'user1', :password => 'user1'})
    assert_redirected_to root_path
    assert_equal users(:one).id, session[:user_id] # ?
    assert_equal 'Acesso confirmado', flash[:notice]
  end

  test "not login" do
    post(:create_session, {:login => 'unknowuser', :password => '?'})
    assert_nil assigns['user']
  end

  test "logout" do
    delete(:logout, nil, {:user_id => users(:one).id})
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end

  test "new user form" do
    get :signup
    assert_response :success
    assert assigns['user']
  end

  # Usuário se cadastrando no sistema
  # não deve ter sessao iniciada
  test "create user" do
    assert_difference('User.count') do
      post :create_user, user: user_to_create
    end
    assert assigns['user']
    assert_redirected_to login_path
  end

  test "online user shouldnot signup" do
    session[:user_id] = users(:one).id
    get :signup
    assert_redirected_to root_path
  end

  test "online user shouldnot submit signup" do
    session[:user_id] = users(:one).id
    post :create_user, user: user_to_create
    assert_redirected_to root_path
  end

  def user_to_create
    {
      login: 'new_user',
      password: 'asdfasdf',
      password_confirmation: 'asdfasdf',
      email: 'new_user@newuser.com',
      name: 'New User'
    }
  end
end
