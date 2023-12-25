# frozen_string_literal: true

class EventSerializer
  include JSONAPI::Serializer
  attributes :name, :date, :venue, :event_organizer
end
