# frozen_string_literal: true

class Customer < ApplicationRecord
  has_secure_password

  has_many :bookings, dependent: :destroy
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, on: :create

  enum gender: { female: 0, male: 1, other: 2 }
end
