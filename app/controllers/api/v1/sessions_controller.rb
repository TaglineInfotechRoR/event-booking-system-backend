# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_request

      def customer_login
        customer = Customer.find_by(email: params[:email])

        if customer&.authenticate(params[:password])
          token = generate_token(customer)
          customer = CustomerSerializer.new(customer).serializable_hash
          render json: { token: token, customer: customer }
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      private

      def generate_token(user)
        secret_key = Rails.application.credentials.jwt_secret_key
        JWT.encode({ user_id: user.id, user_type: user.class.name, exp: 24.hours.from_now.to_i }, secret_key)
      end
    end
  end
end
