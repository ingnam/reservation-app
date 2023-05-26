class Reservation < ApplicationRecord
  belongs_to :guest
  validates :code, presence: true, uniqueness: true
  validates :guest, presence: true

  class << self
    def process(payload)
      parsed_payload = parse_payload(payload)
      guest = Guest.find_or_initialize_by(email: parsed_payload[:guest][:email])
      guest.assign_attributes(parsed_payload[:guest])
      reservation = find_or_initialize_by(code: parsed_payload[:reservation][:code])
      result = {}
      ActiveRecord::Base.transaction do
        if guest.save
          reservation.assign_attributes(parsed_payload[:reservation])
          reservation.guest = guest
          if reservation.save
            result = reservation.serializable_hash
          else
            result = {errors: reservation.errors.full_messages.join(', ')}
          end
        else
          result = {errors: guest.errors.full_messages.join(', ')}
        end
      end
      result
    end

    def get_payload_type(payload)
      subclasses.each do |reservation_type|
        if JSONSchemer.schema(reservation_type::SCHEMA).valid?(payload.with_indifferent_access)
          return reservation_type
        end
      end

      return nil
    end
  end
end
