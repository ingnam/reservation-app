module Reservations
  class PayloadOne < Reservation
    SCHEMA = {
      "type": "object",
      "$schema": "http://json-schema.org/draft-04/schema#",
      "properties": {
        "reservation_code": {
          "type": "string"
        },
        "start_date": {
          "type": "string"
        },
        "end_date": {
          "type": "string"
        },
        "nights": {
          "type": "integer"
        },
        "guests": {
          "type": "integer"
        },
        "adults": {
          "type": "integer"
        },
        "children": {
          "type": "integer"
        },
        "infants": {
          "type": "integer"
        },
        "status": {
          "type": "string"
        },
        "guest": {
          "properties": {
            "first_name": {
              "type": "string"
            },
            "last_name": {
              "type": "string"
            },
            "phone": {
              "type": "string"
            },
            "email": {
              "type": "string"
            }
          },
          "required": ["first_name", "last_name", "phone", "email"]
        },
        "currency": {
          "type": "string"
        },
        "payout_price": {
          "type": "string"
        },
        "security_price": {
          "type": "string"
        },
        "total_price": {
          "type": "string"
        }
      },
      "required": [
        "reservation_code",
        "start_date",
        "end_date",
        "nights",
        "guests",
        "adults",
        "children",
        "infants",
        "status",
        "guest",
        "currency",
        "payout_price",
        "security_price",
        "total_price"
      ]
    }.with_indifferent_access

    class << self
      def parse_payload(payload)
        payload = payload.with_indifferent_access
        reservation_data = payload.slice(
          :start_date,
          :end_date,
          :nights,
          :guests,
          :adults,
          :children,
          :infants,
          :status,
          :currency,
          :payout_price,
          :security_price,
          :total_price,
        )
        reservation_data[:code] = payload[:reservation_code]
        guest_data = payload[:guest].slice(
          :first_name,
          :last_name,
          :email
        )
        guest_data[:phones] = [payload[:guest][:phone]]
        return {
          reservation: reservation_data,
          guest: guest_data
        }
      end
    end

  end
end
