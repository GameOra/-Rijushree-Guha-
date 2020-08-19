
class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :edit, :destroy, :deduct, :subtract]
  before_action :set_product, only: [:show, :new]

  authorize_resource

  def index
    @index = 0
    @items = Item.page(params[:page]).distinct
  end

  def show
    @product = @item.product
    respond_with(@item)
  end

  def new
    @item = Item.new
    respond_with @item
  end

  def create
    @item = Item.find_or_initialize_by(product_id: items_params[:product_id])
    @item.add(items_params[:quantity])
    @item.save
    create_transaction(items_params[:product_id].to_i.abs)
    respond_with(@item)
  end

  def subtract
    authorize! :subtract, @item
  end

  def deduct
    authorize! :deduct, @item
    @item.subtract(items_params[:quantity])
    @item.save
    create_transaction(items_params[:quantity].to_i.abs * -1)
    respond_with(@item, action: :subtract)
  end

  private

  def items_params
    params.require(:item).permit(:quantity, :product_id)
  end

  def set_product
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def create_transaction(quantity)
    Transaction.create(quantity: quantity,
                       transaction_date: Time.zone.now, user: current_user,
                       product: @item.product)
  end
end