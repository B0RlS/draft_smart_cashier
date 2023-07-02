# frozen_string_literal: true

require_relative '../data/model/order'
require_relative 'calculate_order_total_price'

module Services
  class Checkout
    attr_reader :order, :discount_rules

    def initialize(discount_rules)
      @order = Data::Model::Order.new
      @discount_rules = discount_rules
    end

    def scan(item)
      order.add_product(item)
    end

    def total_amount
      Services::CalculateOrderTotalPrice.new(order, discount_rules).call
    end
  end
end
