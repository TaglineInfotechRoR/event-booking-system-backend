# frozen_string_literal: true

class TicketSerializer
  include JSONAPI::Serializer
  attributes :event, :ticket_type, :price, :availability
end
