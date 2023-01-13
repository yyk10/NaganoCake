class Admin::HomesController < ApplicationController

  def top
    @orders = Order.all.page(params[:page]).per(10).order('created_at DESC')
    @cart_item = CartItem.all
    #@order = Order.find(params[:id])
   #@order_detail = @order.order_details
  end


private
  def order_params
   params.require(:order).permit(:customer_id, :name, :postal_code, :address, :price, :postage, :payment_method, :status)
  end

end