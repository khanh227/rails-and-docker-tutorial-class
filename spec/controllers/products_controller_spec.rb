require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:user) { create(:admin_user) }
  let!(:category) { create(:category) }
  let!(:product_1) { create(:product) }
  let!(:product_2) { create(:product) }

  before { sign_in user }

  describe 'GET index' do
    before { get :index }

    specify do
      expect(response).to have_http_status(200) 
      expect(response).to render_template(:index) 
      expect(assigns(:products)).to eq [product_2, product_1]
    end
  end

  describe 'GET new' do
    before { get :new }

    specify do
      expect(response).to have_http_status(200) 
      expect(response).to render_template(:new)
    end
  end 

  describe 'POST create' do
    let(:params) do
    {
      product: {
        name: 'Product',
        description: 'Product Description',
        price: 10000,
        quatity: 1,
        category_id: category.id
      }
    }
    end

    context 'success' do
      specify do
        expect do
          post :create, params: params
        end.to change(Product, :count).by(1)
        product = Product.last
        expect(product.name).to eq 'Product'
        expect(product.description).to eq 'Product Description'
        expect(product.price).to eq 10000
        expect(product.quatity).to eq 1
      end
    end

    context 'failure' do
      before { 
        allow_any_instance_of(Product).to receive(:save).and_return(false) 
      }

      specify do
        expect do
          post :create, params: params
        end.not_to change { Product }
      end 
    end
  end

  describe 'PATCH update' do
    let(:params) do
    {
      name: 'Product 2',
      description: 'Product Description',
      price: 15000,
      quatity: 2,
      category: category.id
    }
    end

    context 'success' do
      specify do
        expect do
          patch :update, params: { product: params, id: product_1.id }
          product_1.reload
          expect(product_1.name).to eq 'Product 2'
          expect(product_1.description).to eq 'Product Description'
          expect(product_1.price).to eq 15000
          expect(product_1.quatity).to eq 2
        end
      end
    end

    context 'failure' do
      before { allow_any_instance_of(Product).to receive(:update).and_return(false) }
      
      specify do
        expect do
          patch :update, params: {product: params, id: product_1.id}
        end.not_to change { product_1 }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    specify do
      expect do
        delete :destroy, params: {id: product_2.id}
      end.to change(Product, :count).by(-1)
      expect(response).to redirect_to products_path
    end
  end
end
