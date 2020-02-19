require 'rails_helper'

describe Products::ExportCsv do
  describe '#perform' do
    let(:service) { Products::ExportCsv.new(Product.order(created_at: :desc)) }
    
    context 'has data' do
      let!(:product_1) do 
        create(:product,
          name: 'product_1',
          description: 'about product_1',
          price: '1000.0',
          enabled: 'true',
          quatity: '8',
          created_at: Date.new(2019, 1, 2)
        )
      end

      let!(:product_2) do
        create(:product,
          name: 'product_2',
          description: 'about product_2',
          price: '4000.0',
          enabled: 'false',
          quatity: '12',
          created_at: Date.new(2019, 1, 1)
        )
      end

      let(:csv_result) do
        "Name,Description,Price,Enabled,Quatity\n" +
        "product_1,about product_1,1000.0,true,8\n" +
        "product_2,about product_2,4000.0,false,12\n"
      end

      specify do
        expect(service.perform).to eq csv_result
      end
    end

    context 'no data' do
      let(:csv_result) do
        "Name,Description,Price,Enabled,Quatity\n"
      end

      specify do
        expect(service.perform).to eq csv_result
      end
    end
  end
end
