# frozen_string_literal: true

class BookingConfirmationJob
  include Sidekiq::Worker

  def perform(customer_id, booking_id)
    customer = Customer.find_by(id: customer_id)
    booking = Booking.find_by(id: booking_id)

    if customer && booking
      Rails.logger.info("Customer details: #{customer.inspect}")
      Rails.logger.info('------------------------------------------')
      Rails.logger.info("Booking Details: #{booking.inspect}")
    else
      Rails.logger.error("Customer or Booking not found for IDs: customer_id=#{customer_id}, booking_id=#{booking_id}")
    end
  end
end
