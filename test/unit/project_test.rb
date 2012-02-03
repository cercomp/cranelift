require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "project validation" do
    p = Project.new
    assert !p.save, "Project should have a name and url"

    p.name = Project.first.name
    assert !p.save, "Name of project should be unique"

    p.name = "Unique Name"
    assert !p.save, "Project should have a url"

    # TODO url dos projetos devem ser no formato de urls
    p.url = "lalalal"
    assert p.save, "Project should be saved, #{p.errors.messages}"

    p.enable_autoupdate = true
    assert !p.save, "If autoupdate is enabled, login and password must exist"

    p.autoupdate_login = "login"
    assert !p.save, "autoupdate_password should exist"

    p.autoupdate_password = "password"
    assert p.save, "Valid project should be saved"
  end

end
