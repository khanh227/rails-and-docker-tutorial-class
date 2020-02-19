require 'rails_helper'

RSpec.describe MenusController, type: :controller do
  render_views
  before { sign_in user }

  let(:product_1) { create(:product, name: 'Product 1') }
  let(:product_2) { create(:product, name: 'Product 2') }
  let(:product_3) { create(:product, name: 'Product 3') }

  let!(:menu_1) { create(:menu, product_ids: [product_1.id, product_2.id]) }
  let!(:menu_2) { create(:menu, product_ids: [product_3.id]) }

    
  context 'Admin User' do
    let!(:user) { create(:admin_user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(response).to have_http_status(200) 
        expect(response).to render_template(:index) 
        expect(assigns(:menus)).to eq [menu_1, menu_2]
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
      let!(:user) { create(:admin_user, email: 'test@test.com') }

      let(:params) do
      {
        menu: {
          menu_name: 'menu 2019-05-15',
          product_ids: [product_1.id,product_2.id],
          created_by: user.id
        }
      }
      end

      context 'success' do
        specify do
          expect do
            post :create, params: params
          end.to change(Menu, :count).by(1)
          menu = Menu.last
          menu.background_img.attach(io: File.open('spec/fixtures/sample.png'), filename: 'sample.png')
          expect(menu.menu_name.to_s).to eq 'menu 2019-05-15'
          expect(menu.products.first.name).to eq 'Product 1'
          expect(menu.products).to eq [product_1, product_2]
          expect(menu.user.email).to eq 'test@test.com'
          expect(menu.background_img.attached?).to eq true
        end
      end

      context 'failure' do
        before { 
          allow_any_instance_of(Menu).to receive(:save).and_return(false) 
        }

        specify do
          expect do
            post :create, params: params
          end.not_to change { Menu }
        end 
      end
    end

    describe 'PATCH update' do
      let(:params) do
      {
        menu: {
          product_ids: [product_3.id],
        }
      }
      end

      context 'success' do
        specify do
          expect do
            patch :update, params: { menu: params, id: menu_1.id }
            menu_1.reload
            expect(menu_1.products.first.name).to eq 'Product 3'
            expect(menu_1.products).to eq product_3
          end
        end
      end

      context 'failure' do
        before { allow_any_instance_of(Menu).to receive(:update).and_return(false) }
        
        specify do
          expect do
            patch :update, params: {menu: params, id: menu_1.id}
          end.not_to change { menu_1 }
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE destroy' do
      specify do
        expect do
          delete :destroy, params: {id: menu_2.id}
        end.to change(Menu, :count).by(-1)
        expect(response).to redirect_to menus_path
      end
    end
  end

  context 'Restaurant User' do
    let!(:user) { create(:restaurant_user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(response).to have_http_status(200) 
        expect(response).to render_template(:index) 
        expect(assigns(:menus)).to eq [menu_1, menu_2]
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
      let!(:user) { create(:restaurant_user, email: 'test@test.com') }

      let(:params) do
      {
        menu: {
          menu_name: '2019-05-25',
          product_ids: [product_1.id,product_2.id],
          created_by: user.id
        }
      }
      end

      context 'success' do
        specify do
          expect do
            post :create, params: params
          end.to change(Menu, :count).by(1)
          menu = Menu.last
          expect(menu.menu_name.to_s).to eq '2019-05-25'
          expect(menu.products.first.name).to eq 'Product 1'
          expect(menu.products).to eq [product_1, product_2]
          expect(menu.user.email).to eq 'test@test.com'
        end
      end

      context 'failure' do
        before { 
          allow_any_instance_of(Menu).to receive(:save).and_return(false) 
        }

        specify do
          expect do
            post :create, params: params
          end.not_to change { Menu }
        end 
      end
    end

    describe 'PATCH update' do
      let(:params) do
      {
        menu: {
          product_ids: [product_3.id],
        }
      }
      end

      context 'success' do
        specify do
          expect do
            patch :update, params: { menu: params, id: menu_1.id }
            menu_1.reload
            expect(menu_1.products.first.name).to eq 'Product 3'
            expect(menu_1.products).to eq product_3
          end
        end
      end

      context 'failure' do
        before { allow_any_instance_of(Menu).to receive(:update).and_return(false) }
        
        specify do
          expect do
            patch :update, params: {menu: params, id: menu_1.id}
          end.not_to change { menu_1 }
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE destroy' do
      specify do
        expect do
          delete :destroy, params: {id: menu_2.id}
        end.to change(Menu, :count).by(-1)
        expect(response).to redirect_to menus_path
      end
    end
  end

  context 'Customer User' do
    let!(:user) { create(:user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(response).to have_http_status(200) 
        expect(response).to render_template(:index) 
        expect(assigns(:menus)).to eq [menu_1, menu_2]
      end
    end

    describe 'GET new' do
      before { get :new }

      specify do
        expect(response).to have_http_status(403) 
        expect(response).not_to render_template(:new)
      end
    end 

    describe 'POST create' do
      let!(:user) { create(:user, email: 'test@test.com') }

      let(:params) do
      {
        menu: {
          menu_name: '2019-05-30',
          product_ids: [product_1.id,product_2.id],
          created_by: user.id
        }
      }
      end

      specify do
        expect do
          post :create, params: params
        end.not_to change { Menu }
        menu = Menu.last
        expect(menu.menu_name.to_s).not_to eq '2019-05-30'
        expect(menu.products.first.name).not_to eq 'Product 1'
        expect(menu.products).not_to eq [product_1, product_2]
        expect(menu.user.email).not_to eq 'testtest@test.com'
      end
    end
    
    describe 'PATCH update' do
      let(:params) do
      {
        menu: {
          product_ids: [product_3.id],
        }
      }
      end

      specify do
        expect do
          patch :update, params: { menu: params, id: menu_1.id }
          menu_1.reload
          expect(menu_1.products.first.name).not_to eq 'Product 3'
          expect(menu_1.products).not_to eq product_3
        end
      end
    end

    describe 'DELETE destroy' do
      specify do
        expect do
          delete :destroy, params: {id: menu_2.id}
        end.not_to change { Menu }
        expect(response).not_to redirect_to menus_path
      end
    end
  end
end
