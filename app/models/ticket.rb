class Ticket < ApplicationRecord
  belongs_to :event
  has_many :bookings, dependent: :destroy
end
