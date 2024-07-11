# frozen_string_literal: true

class EnoughProductsValidator < ActiveModel::Validator
  def validate(record)
    record.placements.each do |placement|
      product = placement.product
      if placement.quantity > product.quantity
        record.errors.add(:base, "#{product.title} is out of stock, only #{product.quantity} left")
        # record.errors[product.title.to_s] << "Is out of stock, just #{product.quantity} left"
      end
    end
  end
end
