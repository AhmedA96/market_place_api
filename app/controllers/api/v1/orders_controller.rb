# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      include Authenticable
      before_action :check_login, only: %i[index]

      def index
        render json: OrderSerializer.new(current_user.orders).serializable_hash
      end
    end
  end
end
