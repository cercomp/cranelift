require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects

  test "project with name validation" do
    assert projects(:one).valid?
  end

end
