require 'test_helper'

module Api
  module V1


    class UsersControllerTest < ActionController::TestCase


      let(:token) {
        stub :accessible?, true
        stub :resource_owner_id, @user.id
      }

      before(type: :all) do
              login_admin
      end

      test "Should return list of general notice recipient users to authenticated user" do

             controller = UsersController.new()
             controller.stub :doorkeeper_token, token do

             controller.index
             userData = JSON.parse(response.body)

              assert_response :success



             end



        end

       test "Should not provide list of users to non-authenticated user" do

           flunk("Test not written")

       end

      test "Should not provide list of users without general notices set" do

          flunk("Test not written")

      end

      test "Should create new user when user doesn't exist" do

         flunk("Test not written")

      end

      test "Creating new user should email reminder to user when the user already exists" do
        #mock the mailer for this test
        flunk("Test not written")

      end

      test "Should not create new user if non-administrator attempts to create one" do
         #mock the mailer for this test
         flunk("Test not written")

      end

    end
  end
end