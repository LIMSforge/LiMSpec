require 'integration_test_helper'

describe "Requirement and question review integration" do
  it 'Should have the back link on the edit page point to the review route when a requirement is being reviewed' do
      authenticate_admin_user
      5.times do
        create(:requirement, status: 'Submitted')
      end
      visit review_requirements_path
      @requirement = Requirement.first
      visit edit_requirement_path(@requirement)
      assert page.has_link?('Back', :href => '/requirements/review')
  end

  it 'Should have the back link on the show page point to the review route when a requirement is being reviewed' do
        authenticate_admin_user
        5.times do
           create(:requirement, status: 'Submitted')
        end
        visit review_requirements_path
        @requirement = Requirement.first
        visit requirement_path(@requirement)
        assert page.has_link?('Back', :href => '/requirements/review')
  end

  it 'Should have the back link on the edit page point to the review route when a question is being reviewed' do
        authenticate_admin_user
        5.times do
          create(:question, status: 'Submitted')
        end
        visit review_questions_path
        @question = Question.first
        visit edit_question_path(@question)
        assert page.has_link?('Back', :href => '/questions/review')
    end

    it 'Should have the back link on the show page point to the review route when a question is being reviewed' do
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
