require 'integration_test_helper'

class RequirementSearchTest < ActionDispatch::IntegrationTest

  test 'Requirement search function returns correct number of results' do

      authenticate_admin_user

       3.times do
         create(:requirement)
       end

       create(:requirement, reqText: 'Sunspot search test')
       Requirement.reindex
       visit requirements_path

       fill_in 'search', with: 'Sunspot'
       click_button 'Search'

       assert page.has_content?('Sunspot search test')

       assert page.has_no_content?('testing things')

    end


end
