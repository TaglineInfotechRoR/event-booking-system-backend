# frozen_string_literal: true

module Api
  module V1
    class TicketsController < ApplicationController
      before_action :find_ticket, only: %i[update destroy]

      def update
        return render_not_found('Ticket not found') unless @ticket

        unless current_user_event_organizer?
          return render_unauthorized_error("You do not have permission to delete this event's ticket.")
        end

        if @ticket.update(ticket_params)
          render_success(serialized_ticket(@ticket), 'Ticket updated successfully')
        else
          render_error(@ticket.errors.full_messages)
        end
      end

      def destroy
        return render_not_found('Ticket not found') unless @ticket

        unless current_user_event_organizer?
          return render_unauthorized_error("You do not have permission to delete this event's ticket.")
        end

        if @ticket.destroy
          render_success(serialized_ticket(@ticket), 'Ticket deleted successfully')
        else
          render_error(@ticket.errors.full_messages)
        end
      end

      private

      def ticket_params
        params.require(:tickets).permit(:ticket_type, :price, :availability)
      end

      def find_ticket
        @ticket = Ticket.find_by(id: params[:id])
      end

      def current_user_event_organizer?
        @current_user.instance_of?(EventOrganizer)
      end

      def serialized_ticket(object)
        TicketSerializer.new(object).serializable_hash
      end
    end
  end
end
