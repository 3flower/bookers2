require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "user_thanks_mail" do
    mail = UserMailer.user_thanks_mail
    assert_equal "User thanks mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
