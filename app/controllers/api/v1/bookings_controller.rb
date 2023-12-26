# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      before_action :check_customer, only: [:create]

      def create
        booking = build_booking

        if booking.save
          update_ticket_availability(booking)
          send_booking_confirmation(booking)
          render_success(serialized_booking(booking), 'Event booked successfully')
        else
          render_error(booking.errors.full_messages)
        end
      end

      private

      def check_customer
        return if @current_user.instance_of?(Customer)

        render_unauthorized_error('You are not authorized to perform this action')
      end

      def booking_params
        params.require(:booking).permit(:event_id, :ticket_id, :quantity, :date, :payment_status)
      end

      def build_booking
        booking = Booking.new(booking_params)
        booking.customer = @current_user
        booking
      end

      def update_ticket_availability(booking)
        ticket = booking.ticket
        remaining_tickets = ticket.availability - booking.quantity

        if remaining_tickets >= 0
          ticket.update(availability: remaining_tickets)
        else
          booking.errors.add(:base, 'Tickets are not available for this event')
        end
      end

      def send_booking_confirmation(booking)
        BookingConfirmationJob.perform_async(@current_user.id, booking.id)
      end

      def serialized_booking(booking)
        binding.pry
        BookingSerializer.new(booking).serializable_hash
      end
    end
  end
end
