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
    res