require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

    test "question number is provided" do
      myQuestion = create(:question)
      assert_equal(myQuestion.questNumber, ("Q-"+ myQuestion.id.to_s))

    end

end
