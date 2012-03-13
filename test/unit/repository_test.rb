require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase

  test "url validation" do
    assert !repositories(:invalid_url).valid?
  end

  test "valid repository" do
    assert repositories(:valid).valid?
  end
  
  test "autoupdate validation" do
    assert !repositories(:invalid_autoupdate).valid?
    assert repositories(:valid_autoupdate).valid?
  end

end
