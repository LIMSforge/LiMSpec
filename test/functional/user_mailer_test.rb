require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "password reset sends email to user" do

    user = create(:user, email:'george@jungle.com', password_reset_token:'fasdlkfjas;ldkfjasldkf;a')

    mail = UserMailer.password_reset(user).deliver
    assert_equal "Password Reset", mail.subject
    assert_equal ["george@jungle.com"], mail.to
    assert_equal ["admin@limspec.com"], mail.from
    assert_match 'To reset your password click the URL below.', mail.body.encoded
  end

  test "password reset sends password reset link to user" do

    flunk("Test not written yet")

  end

  test "should send reminder email to user" do

    flunk("Test not written yet")

  end

  test "reminder email should contain password reset link" do

    flunk("Test not written yet")

  end

  test "should send new user email" do

    flunk("Test not written yet")

  end

  test "new user email should send temporary password" do

    flunk("Test not written yet")

  end

end
