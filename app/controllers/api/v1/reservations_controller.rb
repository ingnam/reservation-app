module Api
  module V1
    class ReservationsController < ApplicationController
      def create
        payload_type = Reservation.get_payload_type(params.to_unsafe_h)
        if payload_type.nil?
          render json: {errors: 'Invalid reservation data'}
        else
          res = payload_type.process(params.to_unsafe_h)
          render json: res
        end
      end

    end
  end
end