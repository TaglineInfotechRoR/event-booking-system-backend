# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      def create
        if @current_user.instance_of?(Customer)
          booking = Booking.new(booking_params)
          booking.customer = @current_user

          if booking.ticket.availability <= 0
            render json: { error: 'Tickets are not available for this event' }, status: :unprocessable_entity
            return
          end

          if booking.save
            ticket = booking.ticket
            remaining_tickets = ticket.availability - booking.quantity
            ticket.update(availability: remaining_tickets)
            BookingConfirmationJob.perform_async(@current_user.id, booking.id)
            booking = BookingSerializer.new(booking).serializable_hash
            render json: { message: 'Event booked successfully', booking: booking }
          else
            render json: { error: booking.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'You do not have permission to book ticket.' }, status: :unauthorized
        end
      end

      private

      def booking_params
        params.require(:booking).permit(:customer, :event_id, :ticket_id, :quantity, :date, :payment_status)
      end
    end
  end
end
