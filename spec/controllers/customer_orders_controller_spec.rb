require 'rails_helper'

RSpec.describe CustomerOrdersController, type: :controller do
  around do |example|
    Timecop.freeze(Time.zone.local(2017, 1, 1, 0, 0, 0)) do
      example.run
    end
  end

  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let!(:customer_order_1) { create(:customer_order, user: user_1) }
  let!(:customer_order_2) { create(:customer_order, user: user_1) }
  let!(:customer_order_3) { create(:customer_order, user: user_2) }

  before { sign_in user }

  describe 'GET index' do
    let(:user) { user_1 }

    before { get :index }

    specify do
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(assigns(:customer_orders).to_a).to eq [customer_order_1, customer_order_2]
    end
  end

  describe 'GET show' do
    let(:user) { user_2 }

    specify do
      get :show, params: { id: customer_order_3.id}
      expect(response).to render_template(:show)
      expect(assigns(:customer_order)).to eq customer_order_3
    end
  end

  describe '#cancel' do
    let(:user) { user_1 }

    context 'success' do
      specify do
        post :cancel, params: { id: customer_order_1 }
        customer_order_1.reload
        expect(customer_order_1.canceled_at).to eq Time.now
        expect(flash[:notice]).to eq 'You canceled order successful!'
      end
    end

    context 'failure' do
      before do
        allow_any_instance_of(CustomerOrder).to receive(:update_attribute).and_return(false)
        post :cancel, params: { id: customer_order_2 }
      end

      specify do
        expect(customer_order_2.canceled_at).to eq nil
        expect(flash[:alert]).to eq 'You canceled order failure!'
      end
    end
  end
end
