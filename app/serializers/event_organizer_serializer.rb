# frozen_string_literal: true

class EventOrganizerSerializer
  include JSONAPI::Serializer
  include CustomSerializableHash

  attributes :first_name, :last_name, :email, :gender, :phone
end
