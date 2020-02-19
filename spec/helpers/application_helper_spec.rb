require 'rails_helper'

describe ApplicationHelper, type: :helper do 
  describe '#app_name' do
    specify do
      expect(app_name).to eq 'Lunch Service'
    end
  end

  describe '#display_status' do
    context 'when true' do
      specify do
        expect(display_status(true)).to eq '<span class="glyphicon glyphicon-ok"></span>'
      end
    end
    context 'when false' do
      specify do
        expect(display_status(false)).to eq '<span class="glyphicon glyphicon-remove"></span>'
      end
    end
  end  
end
