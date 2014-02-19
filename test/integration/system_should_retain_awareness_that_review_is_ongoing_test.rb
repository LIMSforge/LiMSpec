require 'integration_test_helper'

class SystemShouldRetainAwarenessThatReviewIsOngoingTest < ActionDispatch::IntegrationTest
  test 'During requirement review process, the back link on the edit page should point to the review route' do
      authenticate_admin_user
      5.times do
        create(:requirement, status: 'Submitted')
      end
      visit review_requirements_path
      @requirement = Requirement.first
      visit edit_requirement_path(@requirement)
      assert page.has_link?('Back', :href => '/requirements/review')
  end

  test 'During requirement review process, the back link on the show page should point to the review route' do
        authenticate_admin_user
        5.times do
           create(:requirement, status: 'Submitted')
        end
        visit review_requirements_path
        @requirement = Requirement.first
        visit requirement_path(@requirement)
        assert page.has_link?('Back', :href => '/requirements/review')
  end

  test 'During question review process, the back link on the edit page should point to the review route' do
        authenticate_admin_user
        5.times do
          create(:question, status: 'Submitted')
        end
        visit review_questions_path
        @question = Question.first
        visit edit_question_path(@question)
        assert page.has_link?('Back', :href => '/questions/review')
    end

    test 'During question review process, the back link on the show page should point to the review route' do
          authenticate_admin_user
          5.times do
              create(:question, status: 'Submitted')
          end
          visit review_questions_path
          @question = Question.first
          visit question_path(@question)
          assert page.has_link?('Back', :href => '/questions/review')
    end
end
