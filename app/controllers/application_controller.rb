# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = JWT.decode(token, Rails.application.credentials.jwt_secret_key).first
    user_type = decoded_token['user_type']
    user_id = decoded_token['user_id']

    @current_user = user_type.constantize.find(user_id)
  rescue JWT::DecodeError, JWT::VerificationError, JWT::ExpiredSignature
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
