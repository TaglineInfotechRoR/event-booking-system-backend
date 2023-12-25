# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :event_organizer
  has_many :tickets, dependent: :destroy
  accepts_nested_attributes_for :tickets, allow_destroy: true
  has_many :bookings, dependent: :destroy

  validates :name, :date, :venue, presence: true
end
