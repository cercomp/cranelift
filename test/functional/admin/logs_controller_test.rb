require 'test_helper'

class Admin::LogsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    session[:user_id] = @user.id # usuario logado
    @user.update_attribute :role, Role.find_by_name('Gerente')
  end

  test "index ip" do
    get :index
    assert_response :success
    assert assigns['logs']
  end
end
