require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects

  test "project without name validation" do
    assert !projects(:invalid).valid?
  end

  test "project with name validation" do
    assert projects(:one).valid?
  end

end
