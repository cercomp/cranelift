require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase

  test "url validation" do
    assert !repositories(:invalid_url).valid?
  end

  test "valid repository" do
    repo = repositories(:valid).clone
    repo.name = "Other name"
    assert repo.valid?
  end
  
  # Conflito no unique do name, como contornar isso?
  test "autoupdate validation" do
    assert !repositories(:invalid_autoupdate).valid?
    #assert repositories(:valid_autoupdate).valid?
  end

end
