RSpec.describe Services::CalculateOrderTotalPrice do
  subject { described_class.new(order, discount_rules) }

  let(:order) { Data::Model::Order.new }
  let(:discount_rules) { Services::DiscountRuleService.new }
  let(:product_info_1) { { price: price, quantity: 2 } }
  let(:product_info_2) { { price: price, quantity: 3 } }
  let(:discount_1) { Services::Discounts::BuyOneGetOneFree }
  let(:discount_2) { Services::Discounts::Percentage }
  let(:discount_3) { Services::Discounts::Dynamic }
  let(:price) { Money.new(1123, 'GBP') }

  before do
    order.items = items

    allow(discount_rules).to receive(:eligible_discounts).with('GR1').and_return([discount_1, discount_3])
    allow(discount_rules).to receive(:eligible_discounts).with('SR1').and_return([discount_2])
    allow(discount_1).to receive(:applicable?).with(product_info_1[:quantity]).and_return(true)
    allow(discount_1).to receive(:calculate_discount_price).with(product_info_1).and_return(Money.new(1123, 'GBP'))
    allow(discount_3).to receive(:applicable?).with(product_info_1[:quantity]).and_return(false)
    allow(discount_2).to receive(:applicable?).with(product_info_2[:quantity]).and_return(true)
    allow(discount_2).to receive(:calculate_discount_price).with(product_info_2).and_return(Money.new(2244, 'GBP'))
  end

  describe '#call' do
    context 'when order has multiple items' do
      let(:items) { { 'GR1' => product_info_1, 'SR1' => product_info_2 } }

      it 'calculates the total price for the order with different discounts applied' do
        expect(subject.call).to eq(Money.new(3367, 'GBP')) 
      end
    end

    context 'when a product is not eligible for any discount' do
      let(:items) { { 'GR1' => product_info_1 } }

      before do
        allow(discount_rules).to receive(:eligible_discounts).with('GR1').and_return([])
      end

      it 'applies the regular price to the product' do
        expect(subject.call).to eq(product_info_1[:price] * product_info_1[:quantity]) 
      end
    end

    context 'when a product is eligible but does not meet the quantity for a discount' do
      let(:items) { { 'GR1' => product_info_1 } }

      before do
        allow(discount_1).to receive(:applicable?).with(product_info_1[:quantity]).and_return(false)
      end

      it 'applies the regular price to the product' do
        expect(subject.call).to eq(product_info_1[:price] * product_info_1[:quantity]) 
      end
    end

    context 'when a product is eligible for a discount' do
      let(:items) { { 'GR1' => product_info_1 } }

      before do
        allow(discount_rules).to receive(:eligible_discounts).and_return([discount_1])
        allow(discount_1).to receive(:applicable?).and_return(true)
        allow(discount_1).to receive(:calculate_discount_price).and_return(Money.new(1123, 'GBP'))
      end

      it 'applies the discount to the product price' do
        expect(subject.call).to eq(Money.new(1123, 'GBP'))
      end
    end

    context 'when a product is eligible for more than one discount' do
      let(:items) { { 'GR1' => product_info_1 } }

      before do
        allow(discount_1).to receive(:applicable?).and_return(true)
        allow(discount_1).to receive(:calculate_discount_price).and_return(Money.new(2000, 'GBP'))
        allow(discount_3).to receive(:applicable?).and_return(true)
        allow(discount_3).to receive(:calculate_discount_price).and_return(Money.new(1123, 'GBP'))
      end

      it 'applies the best discount to the product price' do
        expect(subject.call).to eq(Money.new(1123, 'GBP'))
      end
    end
  end
end
