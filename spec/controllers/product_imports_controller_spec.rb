require 'rails_helper'

RSpec.describe ProductImportsController, type: :controller do
  let!(:user) { create(:user) }

  before { sign_in user }

  describe '#import' do
    context 'success' do
      before { allow_any_instance_of(Products::Importor).to receive(:perform).and_return(true) } 
    
      specify do
        expect do
          expect(assigns(:success)).to eq 1
          expect(respond).to redirect_to(products_path)
        end
      end
    end

    context 'failure' do
      before { allow_any_instance_of(Products::Importor).to receive(:perform).and_return(false) } 
    
      specify do
        expect do
          expect(assigns(:failure)).to eq 1
        end
      end
    end 
  end
end
