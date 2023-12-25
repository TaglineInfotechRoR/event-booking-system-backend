# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :event_organizer

  validates :name, :date, :venue, presence: true
end
