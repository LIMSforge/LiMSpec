require 'integration_test_helper'

class UserQuestionSearchTest < ActionDispatch::IntegrationTest
  test 'User question search function returns correct number of results' do

      authenticate_admin_user

      3.times do
        create(:user_question, user_id: @adminUser.id)
      end

      create(:user_question, qTitle: 'Sunspot search test', user_id: @adminUser.id)

      UserQuestion.reindex

      visit user_questions_path

      fill_in 'search', with: 'Sunspot'
      click_button 'Search'
      save_and_open_page

      assert page.has_content?('Sunspot search test')

      assert page.has_no_content?('Random user question')

      save_and_open_page

    end
end
