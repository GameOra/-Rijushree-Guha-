
require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) { create(:product) }
  describe 'GET #index' do
    let(:products) { create_list(:product, 2) }

    context 'guest tries to view products' do
      before { get :index }
      it 'does not populate an array of all products' do
        expect(assigns(:products)).to_not match_array(products)
      end
      it 'redirects to new session view' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'authenticated user tries to view products' do
      sign_in_user
      before { get :index }
      it 'populates an array of all products' do
        expect(assigns(:products)).to match_array(products)
      end
      it 'renders index view' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do

    context 'guest tries to view product' do
      before { get :show, params: { id: product } }

      it 'does not assign requested product to @product' do
        expect(assigns(:product)).to_not eq product
      end

      it 'redirects to new session view' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'authenticated user tries to view product' do
      sign_in_user

      before { get :show, params: { id: product } }

      it 'assigns requested product to @product' do
        expect(assigns(:product)).to eq product
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #new' do
    context 'admin tries to create product' do
      sign_in_user
      before do
        @user.add_role(:admin)
        get :new
      end
      it 'assigns a new Product to @product' do
        expect(assigns(:product)).to be_a_new(Product)
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'seller tries to add product' do
      sign_in_user
      before do
        @user.add_role(:seller)
        get :new
      end
      it 'assigns a new Product to @product' do
        expect(assigns(:product)).to_not be_a_new(Product)
      end

      it 'renders new view' do
        expect(response).to_not render_template :new
      end
    end

    context 'contractor tries to add product' do
      sign_in_user
      before do
        @user.add_role(:contractor)
        get :new
      end
      it 'assigns a new Product to @product' do
        expect(assigns(:product)).to_not be_a_new(Product)
      end

      it 'renders new view' do
        expect(response).to_not render_template :new