RSpec.describe Services::Discounts::Dynamic do
  let(:product_info) { { price: price, quantity: quantity } }
  let(:price) { Money.new(311, 'GBP') }

  describe '.calculate_discount_price' do
    subject { described_class.calculate_discount_price(product_info) }

    context 'when quantity is less than 3' do
      let(:quantity) { 2 }

      it 'raises NotApplicableDiscountError' do
        expect { subject }.to raise_error(Errors::NotApplicableDiscountError)
      end
    end

    context 'when quantity is greater than or equal to 3' do
      let(:quantity) { 3 }

      it 'returns discounted price' do
        expect(subject).to eq(Money.new(1350, 'GBP'))
      end
    end
  end

  describe '.applicable?' do
    subject { described_class.applicable?(product_info[:quantity]) }

    context 'when quantity is less than 3' do
      let(:quantity) { 2 }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end

    context 'when quantity is greater than or equal to 3' do
      let(:quantity) { 3 }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end
  end
end
