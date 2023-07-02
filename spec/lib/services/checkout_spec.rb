RSpec.describe Services::Checkout do
  subject { described_class.new(discount_rule_service) }

  let(:discount_rule_service) { Services::DiscountRuleService.new }
  let(:product_service) { Services::ProductService.new }
  let(:product_1) { product_service.add_product('GT1', 'Green Tea', 3.11) }
  let(:product_2) { product_service.add_product('SR1', 'Strawberries', 11.23) }
  let(:discount_name) { 'buy_one_get_one_free' }
  let(:product_code) { 'GT1' }

  describe '#scan' do
    it 'adds product to the order' do
      subject.scan(product_1)
      subject.scan(product_2)

      expect(subject.order.items).to include({
        product_1.product_code => { quantity: 1, price: product_1.price },
        product_2.product_code => { quantity: 1, price: product_2.price }
      })
    end
  end

  describe '#total_amount' do
    before do 
      subject.scan(product_1)
      subject.scan(product_1)
      subject.scan(product_2)
      subject.scan(product_2)
      subject.scan(product_2)

      discount_rule_service.add_discount_rule(discount_name, product_code)
    end

    it 'calculates the total amount for the order' do
      expect(subject.total_amount).to eq(Money.new(3680, 'GBP'))
    end
  end
end
