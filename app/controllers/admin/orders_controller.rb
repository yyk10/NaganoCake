class Admin::OrdersController < ApplicationController
  def show
    @order = Order.new(params[:id])
  end

  def update
  end
  
  private
  def order_params
   params.require(:order).permit(:customer_id, :name, :postal_code, :address, :price, :postage, :payment_method, :status)
  end
end
