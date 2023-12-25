# frozen_string_literal: true

module Api
  module V1
    class TicketsController < ApplicationController
      def update
        ticket = Ticket.find_by(id: params[:id])

        if ticket.nil?
          render json: { error: 'Ticket not found' }, status: :not_found
          return
        end

        if @current_user.instance_of?(EventOrganizer)
          if ticket.update(ticket_params)
            ticket = TicketSerializer.new(ticket).serializable_hash
            render json: { message: 'Ticket updated successfully', ticket: ticket }
          else
            render json: { error: ticket.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: "You do not have permission to update this even's ticket." }, status: :unauthorized
        end
      end

      def destroy
        ticket = Ticket.find_by(id: params[:id])

        if @current_user.instance_of?(EventOrganizer)
          if ticket.destroy
            ticket = TicketSerializer.new(ticket).serializable_hash
            render json: { message: 'Ticket deleted successfully', ticket: ticket }
          else
            render json: { error: ticket.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: "You do not have permission to delete this event's ticket." }, status: :forbidden
        end
      end

      private

      def ticket_params
        params.require(:tickets).permit(:ticket_type, :price, :availability)
      end
    end
  end
end
