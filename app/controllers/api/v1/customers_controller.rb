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

      def update
        if @current_user.instance_of?(Customer)
          if @current_user.update(customer_params)
            customer = CustomerSerializer.new(@current_user).serializable_hash
            render json: { message: 'Customer updates successfully', customer: customer }
          else
            render json: { error: customer.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'You are not authorized to perform this action' }, status: :unauthorized
        end
      end

      def destroy
        if @current_user.instance_of?(Customer)
          if @current_user.destroy
            customer = CustomerSerializer.new(@current_user).serializable_hash
            render json: { message: 'Customer deleted successfully', customer: customer }
          else
            render json: { error: @current_user.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'You are not authorized to perform this action' }, status: :unauthorized
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
