# Backend for a Simple Event Booking System

### Description

This repository contains the backend system for an Event Booking System, catering to two types of users: Event Organizers and Customers. Event Organizers can perform CRUD operations on events, while Customers can book tickets for these events. API access is restricted based on the user's role.

### System Setup (Ruby on Rails)

This project uses the Ruby on Rails framework to create RESTful APIs.

#### Prerequisites

- Ruby 2.7
- Rails 7.1
- Database: PostgreSQL
- Redis

#### Steps to Set Up

1. **Clone the Repository**

    ```bash
    git clone https://github.com/TaglineInfotechRoR/event-booking-system-backend.git
    cd event-booking-system-backend
    ```

2. **Install Dependencies**

    ```bash
    bundle install
    ```

3. **Database Setup**

    Update `config/database.yml` with your database configurations and run:

    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```
4. **Redis and Sidekiq**

   Start redis

   ```bash
   redis-server
   ```
   Start sidekiq

   ```bash
   bundle exec sidekiq
   ```

5. **Start the Server**

    ```bash
    rails server
    ```

6. **API Endpoints**

   Organiser:
     - **Sign up**: `POST /api/v1/organizers/sign_up`
       - Allows a new Event Organizer to register by providing necessary details.
     - **Login**: `POST /api/v1/organizers/login`
       - Enables an Event Organizer to log in, providing authentication credentials
                      (email/password).
	 - **Update**: `PUT /api/v1/event_organizers/:id`
       - Allows an Event Organizer to update their profile details.
     - **Delete**: `DELETE /api/v1/event_organizers/:id`
       - Deletes an Event Organizer's account.

   Customer:
     - **Sign up**: `POST /api/v1/customers/sign_up`
       - Allows a new Customer to register by providing necessary details.
     - **Login**: `POST /api/v1/customers/login`
       - Enables a Customer to log in, providing authentication credentials (email/password).
     - **Update**: `PUT /api/v1/customers/:id`
       - Allows a Customer to update their profile details.
     - **Delete**: `DELETE /api/v1/customers/:id`
       - Deletes a Customer's account.

   Event:
     - **List events**: `GET /api/v1/events`
       - Retrieves a list of available events by organizer.
     - **Create**: `POST /api/v1/events`
       - Allows an Event Organizer to create a new event.
     - **Delete**: `DELETE /api/v1/events/:id`
       - Deletes a specific event.
     - **Update**: `PUT /api/v1/events/:id`
       - Allows an Event Organizer to update event details.

   Booking:
     - **Create**: `POST /api/v1/bookings`
       - Allows a Customer to book tickets for an event.

   Ticket:
     - **Delete**: `DELETE /api/v1/tickets/:id`
       - Deletes a specific ticket type.
     - **Update**: `PUT /api/v1/tickets/:id`
       - Allows an Event Organizer to update ticket details.

