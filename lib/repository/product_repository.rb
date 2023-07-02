# frozen_string_literal: true

module Repository
  class ProductRepository
    attr_reader :products

    def initialize
      @products = []
    end

    def add_product(product)
      products << product
    end
  end
end
