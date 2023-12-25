# frozen_string_literal: true

class EventConfirmationJob
  include Sidekiq::Job
  sidekiq_options queue: :default

  def perform(event_id)
    p ' We have a change on events.'
    p 'Events customers::::::::::::::'
    customers = Event.find(event_id).customers
    p customers.inspect.to_s
  end
end
