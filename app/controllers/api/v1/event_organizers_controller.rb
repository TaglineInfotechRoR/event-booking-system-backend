# frozen_string_literal: true

module Api
  module V1
    class EventOrganizersController < ApplicationController
      skip_before_action :authenticate_request, only: :create
      before_action :set_current_user, except: :create

      def create
        event_organizer = EventOrganizer.new(event_organizer_params)

        if event_organizer.save
          render_success(serialized_organizer(event_organizer), 'Organizer created successfully')
        else
          render_error(event_organizer.errors.full_messages)
        end
      end

      def update
        unless @current_user.instance_of?(EventOrganizer)
          return render_unauthorized_error('You are not authorized to perform this action')
        end

        if @current_user.update(event_organizer_params)
          render_success(serialized_organizer(@current_user), 'Organizer updated successfully')
        else
          render_error(@current_user.errors.full_messages)
        end
      end

      def destroy
        return render_not_authorized unless @current_user.instance_of?(EventOrganizer)

        if @current_user.destroy
          render_success(serialized_organizer(@current_user), 'Organizer deleted successfully')
        else
          render_error(@current_user.errors.full_messages)
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

      def set_current_user
        @current_user = EventOrganizer.find(params[:id])
        render_not_found('Event organizer not found') unless @current_user
      end

      def serialized_organizer(object)
        EventOrganizerSerializer.new(object).serializable_hash
      end
    end
  end
end
