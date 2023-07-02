RSpec.describe Validators::ProductValidator do
  subject { described_class.validate!(product_code, name, price) }

  let(:product_code) { 'P1' }
  let(:name) { 'Green tea' }
  let(:price) { 3.11 }

  describe '.validate!' do
    context 'when product attributes are empty' do
      let(:name) { '' }

      it 'raises EmptyProductAttributesError' do
        expect {subject}.to raise_error(Errors::EmptyProductAttributesError)
      end
    end

    context 'when product code is invalid' do
      let(:product_code) { '@invalid_code' }

      it 'raises InvalidProductCodeError' do
        expect {subject}.to raise_error(Errors::InvalidProductCodeError)
      end
    end

    context 'when product price is invalid' do
      context 'when product price is not a number' do
        let(:price) { 'invalid price' }

        it 'raises InvalidProductPriceError' do
          expect {subject}.to raise_error(Errors::InvalidProductPriceError)
        end
      end

      context 'when product price is not positive' do
        let(:price) { -100.00 }

        it 'raises InvalidProductPriceError' do
          expect {subject}.to raise_error(Errors::InvalidProductPriceError)
        end
      end
    end

    context 'when product is valid' do
      it "doesn't raises an error" do
        expect {subject}.not_to raise_error
      end
    end
  end

  describe '.validate_product_code!' do
    context 'when product code is invalid' do
      let(:product_code) { '@invalid_code' }

      it 'raises InvalidProductCodeError' do
        expect {subject}.to raise_error(Errors::InvalidProductCodeError)
      end
    end

    context 'when product code is valid' do
      it 'raises InvalidProductCodeError' do
        expect {subject}.not_to raise_error
      end
    end
  end
end
