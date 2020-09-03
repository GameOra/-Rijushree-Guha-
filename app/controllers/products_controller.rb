class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def index
    @products = Product.page(params[:page])
    @index = 0
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def create
    @product = Product.create(product_params)
    respond_with(@product)
  end

  def edit
  end

  def update
    @product.update(product_params)
    respond_with @product
  end

  def destroy
    respond_with(@product.destroy)
  end

  private

  def product_params
    params.require(:product).permit(:name, :wieght, :hangar_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
