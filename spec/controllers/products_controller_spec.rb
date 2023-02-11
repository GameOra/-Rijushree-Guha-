
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
      end
    end

    context 'guest tries to add product' do
      before { get :new }
      it 'assigns a new Product to @product' do
        expect(assigns(:product)).to_not be_a_new(Product)
      end

      it 'renders new view' do
        expect(response).to_not render_template :new
      end
    end
  end

  describe 'POST #create' do
    context 'admin tries to create product' do
      sign_in_user
      before { @user.add_role(:admin) }
      context 'with valid attributes' do

        it 'creates a new Product' do
          product
          expect { post :create, params: { product: attributes_for(:product)
            .merge(hangar_id: product.hangar) } }
            .to change(Product, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { product: attributes_for(:product)
            .merge(hangar_id: product.hangar) }
          expect(response).to redirect_to product_path(assigns(:product))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the product' do
          expect { post :create, params: { product: attributes_for(:invalid_product) } }
            .to_not change(Product, :count)
        end

        it 're-renders new view' do
          post :create, params: { product: attributes_for(:invalid_product) }
          expect(response).to render_template :new
        end
      end
    end

    context 'seller tries to create product' do
      sign_in_user
      before { @user.add_role(:seller) }
      it 'does not create a new Product' do
        product
        expect { post :create, params: { product: attributes_for(:product)
          .merge(hangar_id: product.hangar) } }
          .to_not change(Product, :count)
      end

      it 'redirects to new session path' do
        post :create, params: { product: attributes_for(:product)
          .merge(hangar_id: product.hangar) }
        expect(response).to redirect_to products_path
      end
    end

    context 'contractor tries to create product' do
      sign_in_user
      before { @user.add_role(:contractor) }
      it 'does not create a new Product' do
        product
        expect { post :create, params: { product: attributes_for(:product)
          .merge(hangar_id: product.hangar) } }
          .to_not change(Product, :count)
      end

      it 'redirects to new session path' do
        post :create, params: { product: attributes_for(:product)
          .merge(hangar_id: product.hangar) }
        expect(response).to redirect_to products_path
      end
    end

    context 'unauthenticated user tries to create product' do
      it 'does not create a new Product' do
        product
        expect { post :create, params: { product: attributes_for(:product)
          .merge(hangar_id: product.hangar) } }
          .to_not change(Product, :count)
      end

      it 'redirects to new session path' do
        post :create, params: { product: attributes_for(:product)
          .merge(hangar_id: product.hangar) }