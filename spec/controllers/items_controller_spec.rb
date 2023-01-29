
require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:item) { create(:item, quantity: 10) }
  describe 'GET #index' do
    let(:items) { create_list(:item, 2) }

    context 'guest tries to view items' do
      before { get :index }
      it 'does not populate an array of all items' do
        expect(assigns(:items)).to_not match_array(items)
      end
      it 'redirects to new session view' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'admin tries to view items' do
      sign_in_user
      before do
        @user.add_role(:admin)
        get :index
      end
      it 'populates an array of all items' do
        expect(assigns(:items)).to match_array(items)
      end
      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    context 'contractor tries to view items' do
      sign_in_user
      before do
        @user.add_role(:contractor)
        get :index
      end
      it 'populates an array of all items' do
        expect(assigns(:items)).to match_array(items)
      end
      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    context 'seller tries to view items' do
      sign_in_user
      before do
        @user.add_role(:seller)
        get :index
      end
      it 'populates an array of all items' do
        expect(assigns(:items)).to match_array(items)
      end
      it 'renders index view' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do

    context 'guest tries to view item' do
      before { get :show, params: { id: item } }

      it 'does not assign requested item to @item' do
        expect(assigns(:item)).to_not eq item
      end

      it 'redirects to new session view' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'admin tries to view item' do
      sign_in_user

      before do
        @user.add_role(:admin)
        get :show, params: { id: item }
      end

      it 'assigns requested item to @item' do