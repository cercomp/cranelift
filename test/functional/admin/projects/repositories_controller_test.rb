require 'test_helper'

class Admin::Projects::RepositoriesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    session[:user_id] = @user.id # usuario logado
    @user.update_attribute :role, Role.find_by_name('Gerente')
    
    @project = projects(:one)
    @repository = repositories(:valid)
  end

  test "get new" do
    get :new, :project_id => @project.id
    assert_response :success
  end

  test "create repository" do
    assert_difference('Repository.count') do
      post :create, {
        repository: @repository.attributes.slice('project_id', 'name', 'url').
          merge({'name' => 'Another Repo on the Wall'}),
        :project_id => @project.id
      }
    end

    assert_redirected_to @project
  end

  test "get edit" do
    get :edit, { id: @repository, :project_id => @project.id }
    assert_response :success
  end

  test "update repository" do
    put :update, {
      id: @repository,
      repository: @repository.attributes.merge({'enable_autoupdate' => false}),
      project_id: @project.id
    }
    assert_redirected_to @project
  end

  test "destroy repository" do
    assert_difference('Repository.count', -1) do
      delete :destroy, { id: @repository, :project_id => @project.id }
    end

    assert_redirected_to @project
  end
end
