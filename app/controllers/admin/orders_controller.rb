class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total_price = 0
  end

  def update
     @order = Order.find(params[:id])
    if @order.update (order_params)
      flash[:success] = "Order was successfully updated"
    redirect_to admin_order_path
    end
  end

  private
  def order_params
   params.require(:order).permit(:customer_id, :name, :postal_code, :address, :price, :postage, :payment_method, :status)
  end
end
