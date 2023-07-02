# frozen_string_literal: true

module Data
  module Model
    class Order
      attr_accessor :items, :total

      def initialize
        @items = {}
        @total = Money.new(0, 'GBP')
      end

      def add_product(product)
        validate_product(product)

        if product_exists?(product)
          increment_quantity(product)
        else
          add_new_product(product)
        end
      end

      private

      def product_exists?(product)
        items[product.product_code]
      end

      def increment_quantity(product)
        items[product.product_code][:quantity] += 1
      end

      def add_new_product(product)
        items[product.product_code] = { quantity: 1, price: product.price }
      end

      def validate_product(product)
        raise Errors::InvalidProductPriceError unless product.is_a?(Data::Model::Product)
      end
    end
  end
end
