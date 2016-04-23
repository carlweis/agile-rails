require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase

  def setup
    @order = orders(:one)
  end

  test "received" do
    mail = OrderNotifier.received(@order)
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["carl@example.org"], mail.to
    assert_equal ["carl@carlweis.com"], mail.from
    assert_match /1 x Programming Ruby 2.0/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(@order)
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["carl@example.org"], mail.to
    assert_equal ["carl@carlweis.com"], mail.from
    assert_match /1 x Programming Ruby 2.0/, mail.body.encoded
  end

end
