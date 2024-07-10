# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      include Authenticable
      before_action :check_login, only: %i[index show]

      def index
        render json: OrderSerializer.new(current_user.orders).serializable_hash
      end

      def show
        order = current_user.orders.find(params[:id])

        if order
          options = { include: [:products] }
          render json: OrderSerializer.new(order, options).serializable_hash
        else
          head 404
        end
      end
    end
  end
end
