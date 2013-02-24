require 'test_helper'

class Admin::IpsControllerTest < ActionController::TestCase
  setup do
    @ip = ips(:one)
    @user = users(:one)
    session[:user_id] = @user.id # usuario logado
    @user.update_attribute :role, Role.find_by_name('Gerente')
  end

  test "index ip" do
    get :index
    assert_response :success
    assert assigns['ips']
  end

  test "new ip form" do
    get :new
    assert_response :success
    assert assigns['ip']
  end

  test "create ip" do
    assert_difference('Ip.count') do
      post :create, ip: @ip.attributes.slice('ip', 'description', 'cidr')
    end
    assert assigns['ip']
    assert_redirected_to admin_ips_path
  end

  test "delete ip" do
    assert_difference('Ip.count', -1) do
      delete :destroy, id: @ip.id
    end
    assert_redirected_to admin_ips_path
  end
end
