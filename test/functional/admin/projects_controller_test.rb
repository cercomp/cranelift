require 'test_helper'

class Admin::ProjectsControllerTest < ActionController::TestCase
  setup do
    # Apenas usuários logados poderão acessar as funções de projetos
    @user = users(:one)
    session[:user_id] = @user.id # usuario logado
    @user.update_attribute :role, Role.find_by_name('Gerente')

    @project = projects(:one)
    @user.projects << @project
  end


  # Todos os usuários poderão acessar a index de projetos, que listara os projetos
  # pertencentes a ele, exceto o administrador do poderá visualizar todos projetos
  # cadastrados no sistema
  test "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end


  # Usuário devem possuir permissão para criar projetos
  test "get new" do
    get :new
    assert_response :success
  end

  # Igualmente ao anterior
  test "create project" do
    assert_difference('Project.count') do
      post :create, project: {:name => 'Teste'}
    end

    assert_redirected_to admin_project_path(assigns(:project))
  end


  test "show project" do
    get :show, id: @project
    assert_response :success
  end


  # Usuário deve ter permissão para editar o projeto
  test "get edit" do
    get :edit, id: @project
    assert_response :success
  end
  test "update project" do
    put :update, id: @project, project: @project.attributes
    assert_redirected_to admin_project_path(assigns(:project))
  end


  # Usuário deve ter permissão e pertercer a um projeto para destruir
  test "destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert !@user.projects.include?(assigns(:project))
    assert_redirected_to admin_projects_path
  end
end
