# frozen_string_literal: true

class BookingSerializer
  include JSONAPI::Serializer
  include CustomSerializableHash

  attributes :customer, :event, :ticket, :quantity, :date, :payment_status
end
