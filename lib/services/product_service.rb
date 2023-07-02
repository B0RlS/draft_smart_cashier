# frozen_string_literal: true

require_relative '../repository/product_repository'
require_relative '../validators/product_validator'
require_relative '../data/model/product'

module Services
  class ProductService
    attr_reader :product_repository

    def initialize(product_repository = Repository::ProductRepository.new)
      @product_repository = product_repository
    end

    def add_product(product_code, name, price)
      Validators::ProductValidator.validate!(product_code, name, price)

      product = Data::Model::Product.new(product_code, name, price)
      product_repository.add_product(product)

      product
    end
  end
end
