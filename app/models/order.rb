class Order < ApplicationRecord
  validates_with EnoughProductsValidator
  before_validation :set_total!
  belongs_to :user
  validates :total, presence: true
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements
  # validate :validate_quantity_available

  def set_total!
    self.total = products.map(&:price).sum
  end

  def build_placements_with_product_ids_and_quantities(product_ids_and_quantites)
    product_ids_and_quantites.each do |product_id_and_quantity|
      placement = placements.build(
        product_id: product_id_and_quantity[:product_id],
        quantity: product_id_and_quantity[:quantity]
      )
      yeild placement if block_given?
    end
  end

  # def validate_quantity_available
  #   placements.each do |placement|
  #     product = placement.product
  #     if placement.quantity > product.quantity
  #       errors.add(:base, "Order quantity cannot exceed available quantity for #{product.title}")
  #     end
  #   end
  # end
end
