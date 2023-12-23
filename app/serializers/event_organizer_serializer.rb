# frozen_string_literal: true

class EventOrganizerSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name, :email, :gender, :phone
end
