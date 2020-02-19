require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before { sign_in user }

  describe 'admin user' do
    let(:user) { create(:admin_user) }
    let(:user_1) { create(:restaurant_user) }
    let(:user_2) { create(:user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(assigns(:users)).to eq [user, user_1, user_2]
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: user_1.id }
        expect(response).to render_template(:show)
        expect(assigns(:user)).to eq user_1
      end
    end

    describe 'GET edit' do
      specify do
        get :edit, params: { id: user_1.id }
        expect(response).to render_template(:edit)
      end
    end

    describe 'PATCH update' do
      let(:params) do
        {
          user: { role_user: 'customer' },
          id: user_1.id
        }
      end

      context 'success' do
        before { patch :update, params: params }

        specify do
          user_1.reload
          expect(user_1.role_user).to eq 'customer'
          expect(response).to redirect_to(user_path)
        end
      end

      context 'failure' do
        before { allow_any_instance_of(User).to receive(:update).and_return(false) }

        specify do
          expect do
            patch :update, params: params
          end.not_to change { user_1 }
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe 'restaurant user' do
    let(:user) { create(:restaurant_user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(response).to have_http_status(403)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(403)
      end
    end

    describe 'GET edit' do
      specify do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(403)
      end
    end

    describe 'PATCH update' do
      let(:params) do
        {
          user: { role_user: 'customer' },
          id: user.id
        }
      end

      context 'access denied' do
        before { patch :update, params: params }

        specify do
          expect(response).to have_http_status(403)
        end
      end
    end
  end

  describe 'customer user' do
    let(:user) { create(:user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(response).to have_http_status(403)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(403)
      end
    end

    describe 'GET edit' do
      specify do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(403)
      end
    end

    describe 'PATCH update' do
      let(:params) do
        {
          user: { role_user: 'customer' },
          id: user.id
        }
      end

      context 'access denied' do
        before { patch :update, params: params }

        specify do
          expect(response).to have_http_status(403)
        end
      end
    end
  end
end
