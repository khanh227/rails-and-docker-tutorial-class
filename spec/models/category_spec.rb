require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(5).on(:create) }
  end
end
