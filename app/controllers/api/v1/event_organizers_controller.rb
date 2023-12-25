# frozen_string_literal: true

module Api
  module V1
    class EventOrganizersController < ApplicationController
      skip_before_action :authenticate_request, only: :create

      def create
        event_organizer = EventOrganizer.new(event_organizer_params)

        if event_organizer.save
          render json: { message: 'Organizer created successfully' }
        else
          render json: { error: event_organizer.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @current_user.instance_of?(EventOrganizer)

          if event.nil?
            render json: { error: 'Event organizer not found' }, status: :not_found
            return
          end

          if @current_user.update(event_organizer_params)
            customer = EventOrganizerSerializer.new(@current_user).serializable_hash
            render json: { message: 'Organizer updates successfully', customer: customer }
          else
            render json: { error: customer.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
        end
      end

      def destroy
        if @current_user.instance_of?(EventOrganizer)

          if @current_user.nil?
            render json: { error: 'Event organizer not found' }, status: :not_found
            return
          end

          if @current_user.destroy
            customer = EventOrganizerSerializer.new(@current_user).serializable_hash
            render json: { message: 'Organizer deleted successfully', customer: customer }
          else
            render json: { error: customer.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
        end
      end

      private

      def event_organizer_params
        params.require(:event_orgainzer).permit(
          :first_name,
          :last_name,
          :password,
          :password_confirmation,
          :email,
          :phone,
          :gender
        )
      end
    end
  end
end
