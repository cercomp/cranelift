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

end
