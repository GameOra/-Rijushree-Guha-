class Admin::ItemsController < Admin::BaseController

  authorize_resource

  def index
    @index = 0
    @transactions = Transaction.all
    @item