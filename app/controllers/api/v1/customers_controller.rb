# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      skip_before_action :authenticate_request, only: :create
      before_action :authorize_customer, except: :create

      def create
        customer = Customer.new(customer_params)

        if customer.save
          render_success(serialized_customer(customer), 'Customer created successfully')
        else
          render_error(customer.errors.full_messages)
        end
      end

      def update
        if @current_user.update(customer_params)
          render_success(serialized_customer(@current_user), 'Customer updated successfully')
        else
          render_error(@current_user.errors.full_messages)
        end
      end

      def destroy
        if @current_user.destroy
          render_success(serialized_customer(@current_user), 'Customer deleted successfully')
        else
          render_error(@current_user.errors.full_messages)
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

      def authorize_customer
        return if @current_user.instance_of?(Customer)

        render_unauthorized_error('You are not authorized to perform this action')
      end

      def serialized_customer(customer)
        CustomerSerializer.new(customer).serializable_hash
      end
    end
  end
end
