# frozen_string_literal: true

class BookingConfirmationJob
  include Sidekiq::Job
  sidekiq_options queue: :default

  def perform(customer_id, booking_id)
    p "Customer details:#{Customer.find(customer_id).inspect}"
    p '------------------------------------------'
    p "Booking Details::#{Booking.find(booking_id).inspect}"
  end
end
