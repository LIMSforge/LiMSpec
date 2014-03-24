require 'integration_test_helper'

describe "User requirement search integration" do

  it 'Should return correct number of results' do

        authenticate_admin_user

        3.times do
          create(:user_requirement, user_id: @adminUser.id)
        end

        create(:user_requirement, req_title: 'Sunspot search test', user_id: @adminUser.id)

        UserRequirement.reindex

        visit user_requirements_path

        fill_in 'search', with: 'Sunspot'
        click_button 'Search'

        assert page.has_content?('Sunspot search test')

        assert page.has_no_content?('testing things')

      end
end
