# frozen_string_literal: true

require 'money'

module Data
  module Model
    class Product
      attr_reader :product_code, :name, :price

      def initialize(product_code, name, price)
        @product_code = product_code
        @name = name
        @price = product_price_in_cents(price)
      end

      private

      def product_price_in_cents(price)
        Money.new(price.to_d * 100, 'GBP')
      end
    end
  end
end
