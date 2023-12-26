# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Seed Event Organizers
EventOrganizer.find_or_create_by(email: 'organizer@example.com') do |event_organizer|
  event_organizer.first_name = 'OrganizerFirstName'
  event_organizer.last_name = 'OrganizerLastName'
  event_organizer.password = 'password1'
  event_organizer.gender = 1
  event_organizer.phone = '1234567890'
end

# Seed Customers
Customer.find_or_create_by(email: 'customer@example.com') do |customer|
  customer.first_name = 'CustomerFirstName'
  customer.last_name = 'CustomerLastName'
  customer.password = 'password1'
  customer.age = 30
  customer.gender = 2
  customer.phone = '9876543210'
  customer.address = '123 Main St'
end

# Seed Events
event_organizer_ids = EventOrganizer.pluck(:id)
events_data = [
  { event_organizer_id: event_organizer_ids.sample, name: 'EventName1', date: Date.today + 7, venue: 'Venue1' }
]
Event.create!(events_data)

# Seed Tickets
event_ids = Event.pluck(:id)
tickets_data = [
  { event_id: event_ids.sample, ticket_type: 'VIP', price: 100.00, availability: 50 },
  { event_id: event_ids.sample, ticket_type: 'Gold', price: 80.00, availability: 50 },
  { event_id: event_ids.sample, ticket_type: 'Silver', price: 50.00, availability: 50 }
  # Add more tickets as needed
]
Ticket.create!(tickets_data)

# Seed Bookings
customer_ids = Customer.pluck(:id)
event_ids = Event.pluck(:id)
ticket_ids = Ticket.pluck(:id)
bookings_data = [
  { customer_id: customer_ids.sample, event_id: event_ids.sample, ticket_id: ticket_ids.sample, quantity: 2,
    date: Date.today + 7, payment_status: 1 }
]
Booking.create!(bookings_data)
