require 'rails_helper'

RSpec.describe CustomerOrder, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:lunch_order) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:lunch_order_id) }
  end
end
