require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Name is Required"  do
    identity = Identity.new
    identity.email = "test@test.com"
    assert !identity.save, "Saved an identity without a name"
  end
end
