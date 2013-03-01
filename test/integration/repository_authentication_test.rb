require 'test_helper'

class RepositoryAuthenticationTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    visit login_path
    fill_in('login', :with => @user.login)
    fill_in('password', :with => 'user1')
    click_on('Acessar')
    #Capybara.current_driver = :selenium
  end

  test "authenticate in a auth-require repository" do
    repository = repositories(:auth)
    project = repository.project

    visit project_repository_path(project, repository)
    assert current_path == new_project_repository_auth_path(project, repository)

    fill_in('login', :with => 'teste')
    fill_in('pass', :with => 'cercomp')
    click_on('submit')

    assert current_path == project_repository_path(project, repository)
  end
end
