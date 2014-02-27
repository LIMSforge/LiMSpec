require 'test_helper'

class RequirementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Search function returns only requirements matching category" do

     5.times do
       create(:reqWithNamedCat, categoryName: 'Data Model')
     end
     5.times do
       create(:requirement)
     end
     found_requirements = Requirement.catFilter('Data Model')
     total_requirements = Requirement.all
     assert(found_requirements.length > 0)
     assert_not_equal(found_requirements.length, total_requirements.length)
  end

  test "requirement number should be generated with no category assigned" do
    my_req = create(:requirement)
    expected_req_number = "R-" + my_req.id.to_s
    actual_req_number = my_req.reqNumber
    assert_equal(expected_req_number, actual_req_number)
  end

  test "requirement number should be generated with category with nil abbreviation" do
    my_req = create(:requirement)
    expected_req_number = "R-" + my_req.id.to_s
    actual_req_number = my_req.reqNumber
    assert_equal(expected_req_number, actual_req_number)
  end

  test "requirement number should include abbreviation when available" do
    my_req = create(:reqWithNamedCat, categoryName: "User Interface", categoryAbbr: "UI")
    expected_req_number = "RUI-" + my_req.id.to_s
    actual_req_number = my_req.reqNumber
    assert_equal(expected_req_number, actual_req_number)
  end


end
