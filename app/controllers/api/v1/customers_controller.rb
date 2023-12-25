# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      skip_before_action :authenticate_request, only: :create

      def create
        customer = Customer.new(customer_params)

        if customer.save
          render json: { message: 'Customer created successfully' }
        else
          render json: { error: customer.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def customer_params
        params.require(:customer).permit(
          :first_name,
          :last_name,
          :password,
          :password_confirmation,
          :email,
          :phone,
          :gender,
          :age,
          :address
        )
      end
    end
  end
end
