# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      def index
        if @current_user.instance_of?(EventOrganizer)
          events = @current_user.events
          render json: { events: events }
        else
          ender json: { error: 'You do not have permission to view others events.' }, status: :unauthorized
        end
      end

      def create
        if @current_user.instance_of?(EventOrganizer)
          event = Event.new(event_params)
          event.event_organizer_id = @current_user.id
          if event.save
            event = EventSerializer.new(event).serializable_hash
            render json: { message: 'Event created successfully', event: event }
          else
            render json: { error: event.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'You do not have permission to create this event.' }, status: :unauthorized
        end
      end

      def edit; end

      def update
        event = Event.find_by(id: params[:id])

        if event.nil?
          render json: { error: 'Event not found' }, status: :not_found
          return
        end

        if @current_user.instance_of?(EventOrganizer) && @current_user.events.include?(event)
          if event.update(event_params)
            event = EventSerializer.new(event).serializable_hash
            render json: { message: 'Event updated successfully', event: event }
          else
            render json: { error: event.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'You do not have permission to update this event.' }, status: :unauthorized
        end
      end

      def destroy
        event = Event.find_by(id: params[:id])
        if @current_user.instance_of?(EventOrganizer) && @current_user.events.include?(event)
          if event.destroy
            event = EventSerializer.new(event).serializable_hash
            render json: { message: 'Event deleted successfully', event: event }
          else
            render json: { error: event.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'You do not have permission to delete this event.' }, status: :forbidden
        end
      end

      private

      def event_params
        params.require(:event).permit(:name, :date, :venue)
      end
    end
  end
end
