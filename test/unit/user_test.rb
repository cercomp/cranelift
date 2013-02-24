require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "test user validations" do
    user = users(:one)
    assert(user.save, 'user must be valid')

    user.name = ''
    assert(!user.save, 'not save user without name')

    user = users(:one)
    user.login = ''
    assert(!user.save, 'not save user without login')
    
    user1, user2 = users(:one), users(:two)
    user1.login = user2.login
    assert(!user1.save, 'shoud not save duplicated login')

    user2.email = user1.email
    assert(!user2.save, 'shoud not save duplicated email')
  end

  test "test user status" do
    user = users(:one)
    user.last_action = Time.now
    assert(user.status, 'user must be online')

    user.last_action = Time.now - 6*60*60 # - 6 minutos
    assert(!user.status, 'user must be offline')
  end
end
