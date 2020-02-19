require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:products) }
    it { is_expected.to have_many(:menus).with_foreign_key('created_by') }
  end

  describe 'enum' do
    it { is_expected.to define_enum_for(:role_user) }
  end
end
