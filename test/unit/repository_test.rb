require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase

  test "url validation" do
    repo = Repository.new project_id: 1,
      name: 'invalid_url',
      url: 'url_invalida',
      enable_autoupdate: false,
      login: '',
      password: ''

    assert !repo.valid?
  end

  test "valid repository" do
    repo = repositories(:valid).clone
    repo.name = "Other name"
    assert repo.valid?
  end
  
  test "autoupdate validation" do
    invalid = Repository.new project_id: 1,
      name: 'invalid_autoupdate',
      url: 'https://svn.cercomp.ufg.br/pub/teste/',
      enable_autoupdate: true,
      login: 'test',
      password: ''

    valid = Repository.new project_id: 1,
      name: 'valid_autoupdate',
      url: 'https://svn.cercomp.ufg.br/pub/teste/',
      enable_autoupdate: true,
      login: 'login',
      password: 'password'

    assert !invalid.valid?
    assert valid.valid?
  end

end
