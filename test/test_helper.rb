ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'debugger'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Reset roles
  Role.destroy_all
  require Rails.root.join('db', 'seeds', 'permissions_roles.rb')

  # Add more helper methods to be used by all tests here...
  def login(user)
  	open_session do |sess|
      u = users(user)
      sess.https!
      sess.post "/login", :username => u.login, :password => u.password
      assert_equal root_url, path
      sess.https!(false)
    end
  end
end
