RSpec.describe Services::ProductService do
  subject { described_class.new(repository) }

  let(:repository) { instance_double(Repository::ProductRepository) }
  let(:product_code) { 'GT1' }
  let(:name) { 'Green Tea' }
  let(:price) { 3.11 }

  describe '#add_product' do
    let(:product) { instance_double(Data::Model::Product) }

    before do
      allow(Data::Model::Product).to receive(:new).and_return(product)
      allow(repository).to receive(:add_product)
    end

    context 'when attributes are empty' do
      let(:name) { '' }

      it 'raises EmptyProductAttributesError' do
        expect { subject.add_product(product_code, name, price) }.to raise_error(Errors::EmptyProductAttributesError)
      end
    end

    context 'when product code is invalid' do
      let(:product_code) { '@invalid_code' }

      it 'raises InvalidProductCodeError' do
        expect { subject.add_product(product_code, name, price) }.to raise_error(Errors::InvalidProductCodeError)
      end
    end

    context 'when price is not a Money object' do
      let(:price) { 'invalid price' }

      it 'raises InvalidProductPriceError' do
        expect { subject.add_product(product_code, name, price) }.to raise_error(Errors::InvalidProductPriceError)
      end
    end

    context 'when product attributes are valid' do
      it 'creates a new product' do
        subject.add_product(product_code, name, price)

        expect(Data::Model::Product).to have_received(:new).with(product_code, name, price)
      end

      it 'adds the new product to the repository' do
        subject.add_product(product_code, name, price)

        expect(repository).to have_received(:add_product).with(product)
      end
    end
  end
end
