# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_request

      def organizer_login
        authenticate_login('event_organizer')
      end

      def customer_login
        authenticate_login('customer')
      end

      private

      def authenticate_login(model_name)
        klass = model_name.classify.safe_constantize
        user = klass.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          token = generate_token(user)
          user_data = serialize_user(user, "#{klass}Serializer")
          render json: { token: token, data: user_data }
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def generate_token(user)
        secret_key = Rails.application.credentials.secret_key_base
        JWT.encode({ user_id: user.id, user_type: user.class.name, exp: 24.hours.from_now.to_i }, secret_key)
      end

      def serialize_user(user, serializer_name)
        serializer = serializer_name.constantize.new(user)
        serializer.serializable_hash
      end
    end
  end
end
