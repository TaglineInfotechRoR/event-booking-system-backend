# frozen_string_literal: true

class CustomerSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :age, :gender, :address
end
