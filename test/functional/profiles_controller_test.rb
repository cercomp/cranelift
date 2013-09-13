require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "user no logged no have access to edit" do
    get :edit
    assert_redirected_to root_path
    post :update, user: {
      first_name: 'newName'
    }
    assert_redirected_to root_path
  end

  test "edit" do
    session[:user_id] = users(:one).id
    get :edit
    assert_response :success
  end

  test "update" do
    session[:user_id] = users(:one).id
    post :update, user: {
      first_name: 'newName'
    }
    assert assigns['user']
    assert assigns['user'].first_name == 'newName'
    assert_redirected_to root_path
  end
end
