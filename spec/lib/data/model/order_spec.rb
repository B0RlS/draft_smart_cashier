RSpec.describe Data::Model::Order do
  subject { described_class.new }

  let(:product_service) { Services::ProductService.new }
  let(:product_1) { product_service.add_product('GR1', 'Green tea', 3.11) }
  let(:product_2) { product_service.add_product('CF1', 'Coffee', 11.23) }

  describe '#initialize' do
    it 'starts with empty items and total', :aggregate_failures do
      expect(subject.items).to eq({})
      expect(subject.total).to eq(Money.new(0, 'GBP'))
    end
  end

  describe '#add_product' do
    context 'when product is added for the first time' do
      before { subject.add_product(product_1) }

      it 'adds product to items and increments the quantity' do
        expect(subject.items[product_1.product_code]).to eq({ quantity: 1, price: product_1.price })
      end
    end

    context 'when diffent products added to order' do
      before do
        subject.add_product(product_1)
        subject.add_product(product_1)
        subject.add_product(product_2)
      end

      it 'increments the quantity of the same product in the items' do
        expect(subject.items[product_1.product_code]).to eq({ quantity: 2, price: product_1.price })
      end

      it 'adds the products to the order' do
        expect(subject.items).to include({
          product_1.product_code => { quantity: 2, price: product_1.price },
          product_2.product_code => { quantity: 1, price: product_2.price }
        })
      end
    end
  end
end
