# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :event
  belongs_to :ticket

  enum payment_status: { Succeed: 0, Failed: 1, Pending: 2 }
end
