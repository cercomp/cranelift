require 'test_helper'

class Projects::RepositoriesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    session[:user_id] = @user.id # usuario logado
    @user.update_attribute :role, Role.find_by_name('Gerente')
    
    @project = projects(:one)
    @repository = repositories(:valid)
  end

  test "get index" do
    get :index, :project_id => @project.id
    assert_response :success
    assert_not_nil assigns(:repositories)
  end

  test "show repository" do
    get :show, { id: @repository, :project_id => @project.id }
    assert_response :success
  end

  test "repository that need authentication" do
    auth_repo = repositories(:auth)
    get :show, { id: auth_repo, :project_id => @project.id }

    assert_response :redirect
    assert_redirected_to admin_project_repositorie_login_path(@project, auth_repo)
  end

end
