module Api
  module V1
    class UsersController < ApplicationController
      doorkeeper_for :all
      respond_to :json
      skip_before_filter :require_auth, :verify_authenticity_token

      def index
        if (User.find(doorkeeper_token.resource_owner_id).role?(:Administrator))
          respond_with User.generalNoticeRecipients.as_json(only: [:email, :name, :firstname, :lastname, :company, :workPhone, :created_at, :updated_at])
        end
      end

      def create
        #TODO Redo API users controller to be consistent with the main app user controller (esp. with regard to use with identity)
        if (User.find(doorkeeper_token.resource_owner_id).role?(:Administrator))
            user = User.find_by_email(params[:email])
            if user then
              UserMailer.account_reminder(user).deliver
            else
              user = User.new
              user.email = params[:email]
              user.firstname = params[:firstname]
              user.lastname = params[:lastname]
              user.company = params[:company]
              user.name = user.firstname + ' ' + user.lastname
              Identity.create_from_user(user)
              user.generate_token(:password_reset_token)
              user.password_reset_sent_at = Time.zone.now
              user.save!
              authentication = Authentication.new
              authentication.provider = "identity"
              authentication.user_id = user.id
              authentication.uid = user.id
              authentication.save!

              UserMailer.new_account(user).deliver

            end
            #respond_with ({:msg => "success", :location => nil})
            render text: "Success"
        end
      end
    end
  end
end

