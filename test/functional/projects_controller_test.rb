require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    session[:user_id] = users(:one).id # usuario logado
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    users(:one).role = Role.defaults[:gerente]
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: {:name => 'Teste'}
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    users(:one).projects << @project # adiciona o usuário ao projeto
    get :show, id: @project
    assert_response :success
  end

  test "should not show project" do
    users(:one).projects = []
    get :show, id: @project
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    put :update, id: @project, project: @project.attributes
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
