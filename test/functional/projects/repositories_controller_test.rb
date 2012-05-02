require 'test_helper'

class Projects::RepositoriesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    session[:user_id] = @user.id # usuario logado
    @user.update_attribute :role, Role.defaults[:gerente]
    
    @project = projects(:one)
    @repository = repositories(:valid)
  end

  test "should get index" do
    get :index, :project_id => @project.id
    assert_response :success
    assert_not_nil assigns(:repositories)
  end

  test "should show repository" do
    get :show, { id: @repository, :project_id => @project.id }
    assert_response :success
  end

end
