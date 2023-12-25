# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_231_223_124_138) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'bookings', force: :cascade do |t|
    t.bigint 'customer_id', null: false
    t.bigint 'event_id', null: false
    t.bigint 'ticket_id', null: false
    t.integer 'status'
    t.date 'date'
    t.integer 'payment_status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['customer_id'], name: 'index_bookings_on_customer_id'
    t.index ['event_id'], name: 'index_bookings_on_event_id'
    t.index ['ticket_id'], name: 'index_bookings_on_ticket_id'
  end

  create_table 'customers', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.integer 'age'
    t.integer 'gender'
    t.string 'phone'
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.string 'address'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_customers_on_email', unique: true
  end

  create_table 'event_organizers', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'password_digest', null: false
    t.string 'email', null: false
    t.integer 'gender'
    t.string 'phone'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_event_organizers_on_email', unique: true
  end

  create_table 'events', force: :cascade do |t|
    t.bigint 'event_organizer_id', null: false
    t.string 'name'
    t.date 'date'
    t.string 'venue', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_organizer_id'], name: 'index_events_on_event_organizer_id'
  end

  create_table 'tickets', force: :cascade do |t|
    t.bigint 'event_id', null: false
    t.string 'ticket_type'
    t.float 'price'
    t.integer 'availability'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_tickets_on_event_id'
  end

  add_foreign_key 'bookings', 'customers'
  add_foreign_key 'bookings', 'events'
  add_foreign_key 'bookings', 'tickets'
  add_foreign_key 'events', 'event_organizers'
  add_foreign_key 'tickets', 'events'
end
