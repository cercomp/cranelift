require 'test_helper'

class Projects::Repositories::AuthControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    session[:user_id] = @user.id # usuario logado
    @user.update_attribute :role, Role.find_by_name('Gerente')
    
    @project = projects(:one)
    @auth_repo = repositories(:auth)
  end

  test "show repository login form" do
    get :new, { repository_id: @auth_repo, :project_id => @project }

    assert_response :success
  end

  test "successfully auth at repository" do
    post :create, { repository_id: @auth_repo, project_id: @project,
                  auth: { login: 'teste', pass: 'cercomp' } }

    assert_redirected_to project_repository_path(@project, @auth_repo)
  end

  test "dont auth at repository" do
    post :create, { repository_id: @auth_repo, project_id: @project,
                  auth: { login: 'teste', pass: '123' } }

    assert_response :success
    assert_template 'new'
  end
end
