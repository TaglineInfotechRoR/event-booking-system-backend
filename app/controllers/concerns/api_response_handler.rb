# frozen_string_literal: true

module ApiResponseHandler
  extend ActiveSupport::Concern

  def render_success(data = {}, message = 'Request successful')
    render json: { message: message, data: data }, status: :ok
  end

  def render_error(errors, status = :unprocessable_entity)
    render json: { error: errors }, status: status
  end

  def render_unauthorized_error(message = 'Unauthorized')
    render json: { error: message }, status: :unauthorized
  end

  def render_not_found(message = 'Not found')
    render json: { error: message }, status: :not_found
  end
end
