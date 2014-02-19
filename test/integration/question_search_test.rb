require 'integration_test_helper'

class QuestionSearchTest < ActionDispatch::IntegrationTest

  test 'Question search function returns correct number of results' do

      authenticate_admin_user

      3.times do
        create(:question)
      end

      create(:question, qTitle: 'Sunspot search test')

      Question.reindex

      visit questions_path

      fill_in 'search', with: 'Sunspot'
      click_button 'Search'

      assert page.has_content?('Sunspot search test')

      assert page.has_no_content?('Random question')

    end


end
