module Reservations
  class PayloadTwo < Reservation
    SCHEMA = {
      "type": "object",
      "$schema": "http://json-schema.org/draft-04/schema#",
      "properties": {
        "reservation": {
          "properties": {
            "code": {
              "type": "string"
            },
            "start_date": {
              "type": "string"
            },
            "end_date": {
              "type": "string"
            },
            "expected_payout_amount": {
              "type": "string"
            },
            "guest_details": {
              "properties": {
                "localized_description": {
                  "type": "string"
                },
                "number_of_adults": {
                  "type": "integer"
                },
                "number_of_children": {
                  "type": "integer"
                },
                "number_of_infants": {
                  "type": "integer"
                }
              },
              "required": [
                "localized_description",
                "number_of_adults",
                "number_of_children",
                "number_of_infants"
              ]
            },
            "guest_email": {
              "type": "string"
            },
            "guest_first_name": {
              "type": "string"
            },
            "guest_last_name": {
              "type": "string"
            },
            "guest_phone_numbers": {
              "type": "array",
              "items": {
                "type": "string"
              }
            },
            "listing_security_price_accurate": {
              "type": "string"
            },
            "host_currency": {
              "type": "string"
            },
            "nights": {
              "type": "integer"
            },
            "number_of_guests": {
              "type": "integer"
            },
            "status_type": {
              "type": "string"
            },
            "total_paid_amount_accurate": {
              "type": "string"
            }
          },
          "required": [
            "code",
            "start_date",
            "end_date",
            "expected_payout_amount",
            "guest_email",
            "guest_first_name",
            "guest_last_name",
            "guest_phone_numbers",
            "listing_security_price_accurate",
            "host_currency",
            "nights",
            "number_of_guests",
            "status_type",
            "total_paid_amount_accurate"
          ]
        }
      },
      "required": [
        "reservation"
      ]
    }.with_indifferent_access

    class << self
      def parse_payload(payload)
        payload = payload.with_indifferent_access
        reservation_payload = payload[:reservation]
        reservation_data = reservation_payload.slice(
          :code,
          :start_date,
          :end_date,
          :nights
        )
        reservation_data[:guests] = reservation_payload[:number_of_guests]
        reservation_data[:adults] = reservation_payload[:guest_details][:number_of_adults]
        reservation_data[:children] = reservation_payload[:guest_details][:number_of_children]
        reservation_data[:infants] = reservation_payload[:guest_details][:number_of_infants]
        reservation_data[:status] = reservation_payload[:status_type]
        reservation_data[:currency] = reservation_payload[:host_currency]
        reservation_data[:payout_price] = reservation_payload[:expected_payout_amount]
        reservation_data[:security_price] = reservation_payload[:listing_security_price_accurate]
        reservation_data[:total_price] = reservation_payload[:total_paid_amount_accurate]

        return {
          reservation: reservation_data,
          guest: {
            email: reservation_payload[:guest_email],
            first_name: reservation_payload[:guest_first_name],
            last_name: reservation_payload[:guest_last_name],
            phones: reservation_payload[:guest_phone_numbers]
          }
        }
      end
    end

  end
end
