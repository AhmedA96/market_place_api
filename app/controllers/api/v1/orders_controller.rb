# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      include Authenticable
      before_action :check_login, only: %i[index show create]

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

      def create
        order = current_user.orders.build(order_params)

        if order.save
          render json: order, status: :created
        else
          render json: { errors: order.errors }, status: :unprocessable_entity
        end
      end

      private

      def order_params
        params.require(:order).permit(:total, product_ids:[])
      end
    end
  end
end
