# frozen_string_literal: true

class TicketSerializer
  include JSONAPI::Serializer
  include CustomSerializableHash

  attributes :event, :ticket_type, :price, :availability
end
