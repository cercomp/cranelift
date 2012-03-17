require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "new user form" do
    get :new
    assert_response :success
    assert assigns['user']
  end

  # Usuário se cadastrando no sistema
  # não deve ter sessao iniciada
  test "should create user" do
    assert_difference('User.count') do
      post :create, user: user_to_create
    end
    assert assigns['user']
    assert_redirected_to login_path
  end

  test "online user shouldnot signup" do
    session[:user_id] = users(:one).id
    get :new
    assert_redirected_to root_path
  end

  test "online user shouldnot submit signup" do
    session[:user_id] = users(:one).id
    post :create, user: user_to_create
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
