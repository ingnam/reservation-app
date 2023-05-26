class Guest < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, presence: true
  has_many :reservations

  serialize :phones

  after_initialize do |guest|
    guest.phones = [] if guest.phones.nil?
  end
end
