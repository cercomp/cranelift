require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects

  test "project validation" do
    p = Project.new
    assert !p.save, "Project should have a name"

    p.name = Project.first.name
    assert !p.save, "Name of project should be unique"
  end

end
