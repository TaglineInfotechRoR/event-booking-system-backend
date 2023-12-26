# frozen_string_literal: true

module CustomSerializableHash
  extend ActiveSupport::Concern

  def serializable_hash
    data = super
    data[:data]
  end
end
