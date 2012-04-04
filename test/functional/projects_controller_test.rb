require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    # Apenas usuários logados poderão acessar as funções de projetos
    @user = users(:one)
    session[:user_id] = @user.id # usuario logado
    @user.update_attribute :role, Role.defaults[:gerente]

    @project = projects(:one)
    @user.projects << @project
  end


  # Todos os usuários poderão acessar a index de projetos, que listara os projetos
  # pertencentes a ele, exceto o administrador do poderá visualizar todos projetos
  # cadastrados no sistema
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end


  # Usuário devem possuir permissão para criar projetos
  test "should get new" do
    get :new
    assert_response :success
  end
  # Igualmente ao anterior
  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: {:name => 'Teste'}
    end

    assert_redirected_to project_path(assigns(:project))
    assert @user.projects.include?(assigns(:project))
  end


  # Usuário poderam visualizar apenas projetos a qual pertence
  test "should show project" do
    get :show, id: @project
    assert_response :success
  end
  # Igualmente ao anterior
  test "should not show project" do
    users(:one).projects = []
    get :show, id: @project
    assert_response :redirect
    assert_redirected_to root_path
  end


  # Usuário deve ter permissão para editar o projeto
  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end
  test "should update project" do
    put :update, id: @project, project: @project.attributes
    assert_redirected_to project_path(assigns(:project))
  end


  # Usuário deve ter permissão e pertercer a um projeto para destruir
  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert !@user.projects.include?(assigns(:project))
    assert_redirected_to projects_path
  end
end
