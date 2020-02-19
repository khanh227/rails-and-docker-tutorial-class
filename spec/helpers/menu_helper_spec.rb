require 'rails_helper'

describe MenuHelper, type: :helper do
  describe '#menu_list' do
    let!(:menu_1) {create(:menu)}
    let!(:menu_2) {create(:menu)}

    specify do
      expect(menu_list).to eq [[menu_1.menu_name, menu_1.id], [menu_2.menu_name, menu_2.id]]
    end
  end
end
