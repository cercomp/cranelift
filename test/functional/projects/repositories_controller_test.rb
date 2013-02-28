require 'test_helper'

class Projects::RepositoriesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    session[:user_id] = @user.id # usuario logado
    @user.update_attribute :role, Role.find_by_name('Gerente')
    
    @project = projects(:one)
    @repository = repositories(:valid)
    @auth_repo = repositories(:auth)
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
    get :show, { id: @auth_repo, :project_id => @project.id }

    assert_redirected_to new_project_repository_auth_path(@project, @auth_repo)
  end

end
