# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :event
  belongs_to :ticket

  after_create :update_ticket_availability

  enum payment_status: { Succeed: 0, Failed: 1, Pending: 2 }

  validates :quantity, presence: true, numericality: { less_than_or_equal_to: lambda { |booking|
                                                                                booking.ticket.availability
                                                                              } }, if: lambda {
                                                                                         ticket
                                                                                       }

  private

  def update_ticket_availability
    remaining_tickets = ticket.availability - quantity
    ticket.update(availability: remaining_tickets)
  end
end
