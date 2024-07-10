require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'should have positive total' do
    order = orders(:one)
    order.total = -1
    assert_not order.valid?
  end
end
