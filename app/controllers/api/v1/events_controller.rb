# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      before_action :authorize_event_organizer, except: [:index]

      def index
        events = @current_user.events.includes(:event_organizer)
        render_success(serialized_event(events))
      end

      def create
        event = Event.new(event_params)
        event.event_organizer_id = @current_user.id

        if event.save
          render_success(serialized_event(event), 'Event created successfully')
        else
          render_error(event.errors.full_messages)
        end
      end

      def update
        event = Event.find_by(id: params[:id])
        return render_not_found('Event not found') unless event

        unless @current_user.events.include?(event)
          return render_unauthorized_error('You can only update events organized by you.')
        end

        if event.update(event_params)
          perform_async_confirmation(event)
          render_success(serialized_event(event), 'Event updates successfully')
        else
          render_error(event.errors.full_messages)
        end
      end

      def destroy
        event = Event.find_by(id: params[:id])
        return render_not_found('Event not found') unless event

        unless @current_user.events.include?(event)
          render_unauthorized_error('You can only update events organized by you.')
        end

        if event.destroy
          render_success(serialized_event(event), 'Event deleted successfully')
        else
          render_error(event.errors.full_messages)
        end
      end

      private

      def event_params
        params.require(:event).permit(:name, :date, :venue, tickets_attributes: %i[ticket_type price availability])
      end

      def serialized_event(object)
        EventSerializer.new(object).serializable_hash
      end

      def authorize_event_organizer
        return if @current_user.instance_of?(EventOrganizer)

        render_unauthorized_error('You do not have permission for this action.')
      end

      def perform_async_confirmation(event)
        EventConfirmationJob.perform_async(event.id)
      end
    end
  end
end
