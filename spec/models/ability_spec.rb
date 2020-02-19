require 'rails_helper'
require 'cancan/matchers'

describe User do
  let(:ability) { Ability.new(user) }

  describe 'admin user' do
    let(:user) { create(:admin_user) }

    specify do
      expect(ability).to be_able_to(:manage, :all)
    end
  end

  describe 'restaurant user' do
    let(:user) { create(:restaurant_user) }

    specify do
      expect(ability).to be_able_to(:crud, Product)
      expect(ability).to be_able_to(:read, CustomerOrder)
      expect(ability).not_to be_able_to(:cancel, CustomerOrder)
      expect(ability).to be_able_to(:crud, Category)
      expect(ability).to be_able_to(:read, LunchOrder)
      expect(ability).to be_able_to(:crud, Menu)
    end
  end

  describe 'customer user' do
    let(:user) { create(:user) }

    specify do
      expect(ability).not_to be_able_to(:create, Product)
      expect(ability).not_to be_able_to(:update, Product)
      expect(ability).not_to be_able_to(:destroy, Product)
      expect(ability).to be_able_to(:read, Product)
      expect(ability).to be_able_to(:read, CustomerOrder)
      expect(ability).to be_able_to(:cancel, CustomerOrder)
      expect(ability).to be_able_to(:read, Category)
      expect(ability).not_to be_able_to(:crud, LunchOrder)
      expect(ability).to be_able_to(:read, Menu)
    end
  end
end
