require 'test_helper'

class IpTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "ip validation" do
    ip = Ip.new
    assert !ip.valid?

    assert ips(:one).valid?
    assert !ips(:two).valid?
    assert !ips(:three).valid?

    assert ips(:four).allowed?('192.168.0.123')
    assert !ips(:four).allowed?('192.168.1.123')
  end
end
