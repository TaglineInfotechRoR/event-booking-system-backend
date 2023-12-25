class BookingSerializer
  include JSONAPI::Serializer
  attributes :customer, :event, :ticket, :quantity, :date, :payment_status
end
