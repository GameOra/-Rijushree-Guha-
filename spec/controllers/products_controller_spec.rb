
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
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do

    context 'admin tries to update product' do
      sign_in_user
      before { @user.add_role(:admin) }

      context 'with valid attributes' do
        it 'assigns the requested product to @product' do
          patch :update, params: { id: product,
            product: attributes_for(:product) }
          expect(assigns(:product)).to eq product
        end

        it 'change product attributes' do
          patch :update, params: { id: product,
            product: { name: 'new_name', wieght: '111' } }
          product.reload
          expect(product.name).to eq 'new_name'
          expect(product.wieght).to eq 111
        end

        it 'redirects to updated @product' do
          patch :update, params: { id: product,
            product: attributes_for(:product) }
          expect(response).to redirect_to product_path(product)
        end
      end

      context 'with invalid attributes' do
        let(:name) { product.name }
        let(:wieght) { product.wieght }
        before do
          patch :update, params: { id: product,
            product: { name: 'new_name', wieght: nil } }
        end
        it 'does not change @product attributes' do
          product.reload
          expect(product.name).to eq name
          expect(product.wieght).to eq wieght
        end

        it 're-renders edit view' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'seller user tries to update product' do
      let(:name) { product.name }
      let(:wieght) { product.wieght }
      sign_in_user

      before do
        @user.add_role(:seller)
        patch :update, params: { id: product,
          product: { name: 'new_name', body: '111' } }
      end
      it 'does not update product attributes' do
        product.reload
        expect(product.name).to eq name
        expect(product.wieght).to eq wieght
      end

      it 'redirects to new sesseion path' do
        expect(response).to redirect_to products_path
      end
    end

    context 'contractor user tries to update product' do
      let(:name) { product.name }
      let(:wieght) { product.wieght }
      sign_in_user

      before do
        @user.add_role(:contractor)
        patch :update, params: { id: product,
          product: { name: 'new_name', body: '111' } }
      end
      it 'does not update product attributes' do
        product.reload
        expect(product.name).to eq name
        expect(product.wieght).to eq wieght
      end

      it 'redirects to new sesseion path' do
        expect(response).to redirect_to products_path
      end
    end

    context 'unauthenticated user tries to update product' do
      let(:name) { product.name }
      let(:wieght) { product.wieght }
      before do
        patch :update, params: { id: product,
          product: { name: 'new_name', body: '111' } }
      end
      it 'does not update product attributes' do
        product.reload
        expect(product.name).to eq name
        expect(product.wieght).to eq wieght
      end

      it 'redirects to new sesseion path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do

    context 'admin tries to delete product' do
      sign_in_user
      before do
        @user.add_role(:admin)
        product
      end

      it 'deletes product' do
        expect { delete :destroy, params: { id: product } }
          .to change(Product, :count).by(-1)
      end

      it 'redirects to index view' do
        delete :destroy, params: { id: product }
        expect(response).to redirect_to products_path
      end
    end

    context 'seller tries to delete product' do
      sign_in_user
      before do
        @user.add_role(:seller)
        product
      end
      it 'does not deletes product' do
        expect { delete :destroy, params: { id: product } }
          .to_not change(Product, :count)
      end

      it 'redirects to new session path' do
        delete :destroy, params: { id: product }
        expect(response).to redirect_to products_path
      end
    end

    context 'contractor tries to delete product' do
      sign_in_user
      before do
        @user.add_role(:contractor)
        product
      end
      it 'does not deletes product' do
        expect { delete :destroy, params: { id: product } }
          .to_not change(Product, :count)
      end

      it 'redirects to new session path' do
        delete :destroy, params: { id: product }
        expect(response).to redirect_to products_path
      end
    end

    context 'unauthenticated user tries to delete product' do
      it 'does not deletes product' do
        product
        expect { delete :destroy, params: { id: product } }
          .to_not change(Product, :count)
      end

      it 'redirects to new session path' do
        delete :destroy, params: { id: product }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end