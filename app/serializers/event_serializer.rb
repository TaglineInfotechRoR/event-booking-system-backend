# frozen_string_literal: true

class EventSerializer
  include JSONAPI::Serializer
  include CustomSerializableHash

  attributes :name, :date, :venue

  attribute :event_orgainzer do |event|
    EventOrganizerSerializer.new(event.event_organizer).serializable_hash
  end
end
