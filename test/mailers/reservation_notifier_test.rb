require 'test_helper'

class ReservationNotifierTest < ActionMailer::TestCase
  test "reserved" do
    mail = ReservationNotifier.reserved
    assert_equal "Reserved", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "cancelled" do
    mail = ReservationNotifier.cancelled
    assert_equal "Cancelled", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
