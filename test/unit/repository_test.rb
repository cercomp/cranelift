require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  fixtures :repositories, :projects

  test "repository validation" do
    r = Repository.new
    r.project = projects :one
    assert !r.save, "Project should have a url"

    # TODO url dos projetos devem ser no formato de urls
    r.url = "lalalal"
    assert r.save, "Project should be saved, #{r.errors.messages}"

    r.enable_autoupdate = true
    assert !r.save, "If autoupdate is enabled, login and password must exist"

    r.autoupdate_login = "login"
    assert !r.save, "autoupdate_password should exist"

    r.autoupdate_password = "password"
    assert r.save, "Valid project should be saved"
  end

end
