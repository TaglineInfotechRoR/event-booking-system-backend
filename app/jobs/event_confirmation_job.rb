# frozen_string_literal: true

class EventConfirmationJob
  include Sidekiq::Worker

  def perform(event_id)
    Rails.logger.info('We have a change on events.')
    Rails.logger.info('Events customers.')

    event = Event.find_by(id: event_id)
    if event
      customers = event.customers
      Rails.logger.info(customers.inspect.to_s)
    else
      Rails.logger.error("Event not found for ID: #{event_id}")
    end
  end
end
