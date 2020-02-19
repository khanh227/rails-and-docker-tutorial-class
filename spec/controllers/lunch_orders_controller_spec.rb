require 'rails_helper'

RSpec.describe LunchOrdersController, type: :controller do
  before { sign_in user }

  let!(:lunch_order_1) { create(:lunch_order, order_date: Date.today) }
  let!(:lunch_order_2) { create(:lunch_order, order_date: Date.today + 1) }

  describe 'Admin User' do
    let!(:user) { create(:admin_user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(assigns(:lunch_orders).to_a).to eq [lunch_order_1, lunch_order_2]
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: lunch_order_1.id }
        expect(assigns(:lunch_order)).to eq lunch_order_1
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'Restaurant User' do
    let!(:user) { create(:restaurant_user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(assigns(:lunch_orders).to_a).to eq [lunch_order_1, lunch_order_2]
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: lunch_order_1.id }
        expect(assigns(:lunch_order)).to eq lunch_order_1
        expect(response).to render_template(:show)
      end
    end

  end

  describe 'Customer User' do
    let!(:user) { create(:user) }

    describe 'GET index' do
      before { get :index }

      specify do  
        expect(assigns(:lunch_orders).to_a).not_to eq [lunch_order_1, lunch_order_2]
        expect(response).to have_http_status(403)
        expect(response).not_to render_template(:index)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: lunch_order_1.id }
        expect(assigns(:lunch_order)).not_to eq lunch_order_2
        expect(response).not_to render_template(:show)
      end
    end
  end
end
