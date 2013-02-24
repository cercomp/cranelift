require 'test_helper'

class Admin::Projects::RepositoriesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    session[:user_id] = @user.id # usuario logado
    @user.update_attribute :role, Role.find_by_name('Gerente')
    
    @project = projects(:one)
    @repository = repositories(:valid)
  end

  test "should get index" do
    get :index, :project_id => @project.id
    assert_response :success
    assert_not_nil assigns(:repositories)
  end

  test "should get new" do
    get :new, :project_id => @project.id
    assert_response :success
  end

  test "should create repository" do
    assert_difference('Repository.count') do
      post :create, {
        repository: @repository.attributes.slice('project_id', 'name', 'url').
          merge({'name' => 'Another Repo on the Wall'}),
        :project_id => @project.id
      }
    end

    assert_redirected_to admin_project_path(@project)
  end

  test "should show repository" do
    get :show, { id: @repository, :project_id => @project.id }
    assert_response :success
  end

  test "should get edit" do
    get :edit, { id: @repository, :project_id => @project.id }
    assert_response :success
  end

  test "should update repository" do
    put :update, {
      id: @repository,
      repository: @repository.attributes.merge({'enable_autoupdate' => false}),
      project_id: @project.id
    }
    assert_redirected_to edit_admin_project_repository_path(@project, assigns(:repository))
  end

  test "should destroy repository" do
    assert_difference('Repository.count', -1) do
      delete :destroy, { id: @repository, :project_id => @project.id }
    end

    assert_redirected_to admin_project_repositories_path(@project)
  end
end
