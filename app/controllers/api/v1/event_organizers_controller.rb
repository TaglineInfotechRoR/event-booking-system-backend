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
