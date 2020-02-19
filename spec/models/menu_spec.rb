require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).with_foreign_key('created_by') }
  end

  describe '#products' do
    let(:product_1) { create(:product) }
    let(:product_2) { create(:product) }
    let(:product_3) { create(:product) }
    let!(:menu_1) { create(:menu, product_ids: [product_1.id, product_2.id]) }
    let!(:menu_2) { create(:menu, product_ids: [product_3.id]) }
    let!(:menu_3) { create(:menu) }
    
    specify do
      menu_3.background_img.attach(io: File.open('spec/fixtures/sample.png'), filename: 'file.png')
      expect(menu_1.products).to eq [product_1, product_2]
      expect(menu_2.products).to eq [product_3]
      expect(menu_3.background_img).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end
end
